import 'package:flutter/material.dart';

class InputPostDialog extends StatelessWidget {
  const InputPostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    return AlertDialog(
      title: const Text('入力フォーム'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'タイトル'),
            controller: titleController,
          ),
          const SizedBox(height: 8),
          TextField(
            maxLines: 3,
            decoration: const InputDecoration(labelText: '本文'),
            controller: bodyController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'title': titleController.text,
              'body': bodyController.text,
            });
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
