import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'view_model/voice_view_model.dart';

@RoutePage()
class VoicePage extends HookConsumerWidget {
  const VoicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voiceViewModelProvider);
    final viewModel = ref.read(voiceViewModelProvider.notifier);
    final SpeechToText speechToText = useMemoized(() => SpeechToText());
    final isAvailable = useState(false);
    final isListening = useState(false);

    /// 音声入力開始ボタンの押下処理
    /// 音声入力を開始し、入力されたテキストを保存する関数
    void startListening() {
      if (!isListening.value) {
        isListening.value = true;
        speechToText.listen(onResult: (result) {
          viewModel.setSpeechResult(result.recognizedWords);
        });
      } else {
        isListening.value = false;
        speechToText.stop();
      }
    }

    useEffect(() {
      () async {
        final available = await speechToText.initialize();
        isAvailable.value = available;
      }();

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('音声入力')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    state.speechResult.isNotEmpty
                        ? state.speechResult
                        : '音声認識結果がここに出ます',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAvailable.value ? startListening : null,
                    child: Text(isListening.value ? '音声入力終了' : '音声入力開始'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
