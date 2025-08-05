import 'package:flutter/material.dart';

class AndroidAlertDialog extends StatelessWidget {
  const AndroidAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('タイトル'),
      content: const Text('コンテンツ'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}
