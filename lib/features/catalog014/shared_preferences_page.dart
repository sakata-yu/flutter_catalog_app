import 'package:catalog_app_flutter/core/config/app_constants.dart';
import 'package:catalog_app_flutter/core/preference/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/preference/providers.dart';
import '../../core/router/app_router.dart';

@RoutePage()
class SharedPreferencesPage extends HookConsumerWidget {
  const SharedPreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PreferencesService preferenceService =
        ref.watch(preferencesServiceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('SharedPreferences')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final bool alreadyShown = await preferenceService
                    .getBool(AppConstants.preferenceAlreadyShownKey);
                if (alreadyShown && context.mounted) {
                  context.router.push(const SharedPreferencesSimpleRoute());
                } else {
                  await preferenceService.setBool(
                      AppConstants.preferenceAlreadyShownKey, true);
                  if (context.mounted) {
                    context.router.push(const SharedPreferencesOnceRoute());
                  }
                }
              },
              child: const Text('ページ遷移'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await preferenceService.clear();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ローカルデータが消去されました'),
                    ),
                  );
                }
              },
              child: const Text('ローカルデータ消去'),
            ),
          )
        ],
      ),
    );
  }
}
