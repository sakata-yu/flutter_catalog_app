import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('ログイン', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: 'メールアドレス')),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(labelText: 'パスワード'),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () {}, child: const Text('ログイン')),
        ],
      ),
    );
  }
}
