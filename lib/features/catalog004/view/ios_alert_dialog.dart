import 'package:flutter/cupertino.dart';

class IosAlertDialog extends StatelessWidget {
  const IosAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('タイトル'),
      content: const Text('コンテンツ'),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('OK'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}
