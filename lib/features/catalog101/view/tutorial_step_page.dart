import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TutorialStepPage extends StatelessWidget {
  const TutorialStepPage({
    super.key,
    required this.animation,
    required this.title,
    required this.description,
    required this.isShowStartButton,
  });

  final String animation;
  final String title;
  final String description;
  final bool isShowStartButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Lottie.asset(animation, height: 350),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          if (isShowStartButton) ...<Widget>[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('チュートリアル完了'),
                  ),
                );
              },
              child: const Text('はじめる'),
            ),
          ],
        ],
      ),
    );
  }
}
