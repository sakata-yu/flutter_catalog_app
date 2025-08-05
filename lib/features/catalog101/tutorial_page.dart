import 'package:catarog_app_flutter/features/catalog101/view/tutorial_step_page.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/asset_gen/assets.gen.dart';

@RoutePage()
class TutorialPage extends HookConsumerWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('チュートリアル')),
      body: PageView(
        children: <Widget>[
          TutorialStepPage(
            animation: Assets.lottie.tutorial1,
            title: 'ようこそ',
            description: 'このアプリへようこそ。',
            isShowStartButton: false,
          ),
          TutorialStepPage(
            animation: Assets.lottie.tutorial2,
            title: '使い方を紹介',
            description: '画面をスワイプして進めます。',
            isShowStartButton: false,
          ),
          TutorialStepPage(
            animation: Assets.lottie.tutorial3,
            title: 'さあ、始めよう！',
            description: '下のボタンを押して利用開始。',
            isShowStartButton: true,
          ),
        ],
      ),
    );
  }
}
