import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TransitionNoticePage extends StatelessWidget {
  const TransitionNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('お知らせ'),
    );
  }
}
