import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TransitionMyPage extends StatelessWidget {
  const TransitionMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('マイページ'),
    );
  }
}
