import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/asset_gen/assets.gen.dart';

@RoutePage()
class HeroAnimationDetailPage extends HookConsumerWidget {
  const HeroAnimationDetailPage({
    super.key,
    this.animationKey,
  });

  final String? animationKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heroアニメーション詳細')),
      body: Column(
        children: <Widget>[
          Hero(
            tag: animationKey ?? '',
            child: Image.asset(Assets.images.sample.path),
          ),
        ],
      ),
    );
  }
}
