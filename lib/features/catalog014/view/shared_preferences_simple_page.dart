import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SharedPreferencesSimplePage extends StatelessWidget {
  const SharedPreferencesSimplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2回目以降ページ')),
      body: const Center(
        child: Text('このページは2回目以降に表示されます'),
      ),
    );
  }
}
