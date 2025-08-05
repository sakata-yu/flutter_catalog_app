import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {

  const CounterText({
    super.key,
    required this.count,
  });
  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count',
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
