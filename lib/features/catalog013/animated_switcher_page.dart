import 'package:catalog_app_flutter/features/catalog013/view/login_form.dart';
import 'package:catalog_app_flutter/features/catalog013/view/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AnimatedSwitcherPage extends HookConsumerWidget {
  const AnimatedSwitcherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLogin = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Animated Switcher')),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: isLogin.value
              ? const LoginForm(key: ValueKey<String>('login'))
              : const SignupForm(key: ValueKey<String>('signup')),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () => isLogin.value = !isLogin.value,
          child: Text(isLogin.value
              ? '新規登録はこちら'
              : 'すでにアカウントをお持ちですか？ログインする'),
        ),
      ),
    );
  }
}
