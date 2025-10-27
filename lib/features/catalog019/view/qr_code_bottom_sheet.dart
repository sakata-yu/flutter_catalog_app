import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeBottomSheet extends HookConsumerWidget {
  const QrCodeBottomSheet({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // ← キーボード重なり対策
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          maxHeight: 400,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              QrImageView(
                data: text,
                version: QrVersions.auto,
                size: 300,
                gapless: true,
                errorCorrectionLevel: QrErrorCorrectLevel.M,
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: theme.colorScheme.onSurface,
                ),
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String text,
  }) async =>
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => QrCodeBottomSheet(
          text: text,
        ),
      );
}
