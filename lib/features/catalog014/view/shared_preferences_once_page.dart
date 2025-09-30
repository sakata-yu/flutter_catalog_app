import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SharedPreferencesOncePage extends StatelessWidget {
  const SharedPreferencesOncePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('初回専用ページ')),
      body: const Center(
        child: Text('このページは初回のみ表示されます'),
      ),
    );
  }
}
