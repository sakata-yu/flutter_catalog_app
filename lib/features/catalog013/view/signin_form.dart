import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      key: key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('新規登録', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: 'ユーザー名')),
          const SizedBox(height: 8),
          const TextField(decoration: InputDecoration(labelText: 'メールアドレス')),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(labelText: 'パスワード'),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () {}, child: const Text('登録')),
        ],
      ),
    );
  }
}
