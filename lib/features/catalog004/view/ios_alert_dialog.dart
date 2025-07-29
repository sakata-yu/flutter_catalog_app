import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosAlertDialog extends StatelessWidget {
  const IosAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("タイトル"),
      content: Text("コンテンツ"),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("OK"),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("キャンセル"),
        ),
      ],
    );
  }
}
