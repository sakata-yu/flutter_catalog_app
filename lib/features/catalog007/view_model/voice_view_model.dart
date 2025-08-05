import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/voice_state.dart';

final StateNotifierProvider<VoiceViewModel, VoiceState> voiceViewModelProvider =
    StateNotifierProvider<VoiceViewModel, VoiceState>(
        (Ref ref) => VoiceViewModel());

class VoiceViewModel extends StateNotifier<VoiceState> {
  VoiceViewModel() : super(const VoiceState());

  /// 音声入力されたテキストを保存する関数
  ///
  /// Parameters:
  /// - [speechResult] 説明: 音声入力されたテキスト
  ///
  void setSpeechResult(String speechResult) {
    state = state.copyWith(speechResult: speechResult);
  }
}
