import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class QrCodeReadPage extends StatelessWidget {
  const QrCodeReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isProcessing = false;

    return MobileScanner(
      controller:
          MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates),
      onDetect: (BarcodeCapture capture) {
        final String? code = capture.barcodes.first.rawValue;
        if (code != null && !isProcessing) {
          isProcessing = true;
          context.router.pop(code);
        }
      },
    );
  }
}
