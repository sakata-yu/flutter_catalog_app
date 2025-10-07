import 'package:catalog_app_flutter/core/hive/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HiveUserInputDialog extends HookConsumerWidget {
  const HiveUserInputDialog({
    super.key,
    this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController =
        useTextEditingController(text: user?.name);
    final TextEditingController ageController =
        useTextEditingController(text: user?.age.toString());

    return AlertDialog(
      title: const Text(
        'ユーザー情報の入力',
        style: TextStyle(fontSize: 16),
      ),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '名前',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '年齢',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            final String name = nameController.text.trim();
            final String ageText = ageController.text.trim();
            final int? age = int.tryParse(ageText);

            if (name.isNotEmpty && age != null) {
              Navigator.of(context).pop(
                User(
                  name: name,
                  age: age,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('正しい名前と年齢を入力してください')),
              );
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }

  static Future<User?> show(
    BuildContext context, {
    User? user,
  }) {
    return showDialog<User>(
      context: context,
      builder: (_) => HiveUserInputDialog(
        user: user,
      ),
    );
  }
}
