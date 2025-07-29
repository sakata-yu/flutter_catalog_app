import 'package:flutter/material.dart';

class AndroidAlertDialog extends StatelessWidget {
  const AndroidAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("タイトル"),
      content: Text("コンテンツ"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("OK"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("キャンセル"),
        ),
      ],
    );
  }
}
