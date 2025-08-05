import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TransitionSimplePage extends StatelessWidget {
  const TransitionSimplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("シンプルなページ"),
      ),
      body: Center(
        child: Text("シンプルなページ"),
      ),
    );
  }
}
