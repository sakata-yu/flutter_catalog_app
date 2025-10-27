import 'package:catalog_app_flutter/core/router/app_router.dart';
import 'package:catalog_app_flutter/features/catalog019/view/qr_code_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class QrCodePage extends HookConsumerWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = useTextEditingController();
    final ValueNotifier<String> qrResult = useState('');

    return Scaffold(
      appBar: AppBar(title: const Text('QRCode生成・読み取り画面')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (qrResult.value.isNotEmpty)
                ..._buildQrResultWidget(qrResult.value),
              const SizedBox(height: 12),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hint: Text('ここに入力した内容がQRコードになります'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    QrCodeBottomSheet.show(
                        context: context, text: textController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        content: Text('テキストを入力してください'),
                      ),
                    );
                  }
                },
                child: const Text('QRコード生成'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final String? result = await context.router
                      .push<String>(const QrCodeReadRoute());
                  if (result != null) {
                    qrResult.value = result;
                  }
                },
                child: const Text('QRコード読み取り画面へ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildQrResultWidget(String text) {
    return <Widget>[
      const Text('QRスキャン結果'),
      Text(text),
      const SizedBox(height: 12),
    ];
  }
}
