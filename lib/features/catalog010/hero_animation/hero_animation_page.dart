import 'package:catalog_app_flutter/core/config/app_constants.dart';
import 'package:catalog_app_flutter/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/asset_gen/assets.gen.dart';

@RoutePage()
class HeroAnimationPage extends HookConsumerWidget {
  const HeroAnimationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heroアニメーション')),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          final String animationKey = '${AppConstants.heroAnimationKey}$index';
          return ListTile(
            leading: Hero(
              tag: animationKey,
              child: Image.asset(Assets.images.sample.path),
            ),
            title: const Text('Heroアニメーション'),
            onTap: () => context.router.push(
              HeroAnimationDetailRoute(animationKey: animationKey),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}
