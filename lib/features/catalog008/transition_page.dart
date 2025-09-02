import 'package:catalog_app_flutter/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class TransitionPage extends HookConsumerWidget {
  const TransitionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void transitSimplePage() {
      context.router.push(const TransitionSimpleRoute());
    }

    void transitBottomNavigationPage() {
      context.router.push(const TransitionTabsShellRoute());
    }

    void transitDrawerPage() {
      context.router.push(const TransitionDrawerRoute());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('画面遷移')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: transitSimplePage,
              child: const Text('シンプルな遷移'),
            ),
            ElevatedButton(
              onPressed: transitBottomNavigationPage,
              child: const Text('BottomNavigationBarを表示するページ'),
            ),
            ElevatedButton(
              onPressed: transitDrawerPage,
              child: const Text('NavigationDrawerを表示するページ'),
            ),
          ],
        ),
      ),
    );
  }
}
