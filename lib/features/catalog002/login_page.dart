import 'package:auto_route/auto_route.dart';
import 'package:catarog_app_flutter/features/catalog002/data/auth_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view_model/login_view_model.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final authState = ref.watch(authProvider);
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final userState = authState.isLoggedIn ? "ログイン中" : "ログアウト中";

    useEffect(() {
      // 画面破棄時にメモリリークを防ぐためdispose
      return () {
        emailController.dispose();
        passwordController.dispose();
      };
    }, []);

    /// 概要: ログインボタンが押された時の処理
    void login() {
      if (formKey.currentState?.validate() ?? false) {
        // バリデーション成功
        viewModel.login();
      } else {
        // バリデーション失敗
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('値が正しくありません')),
        );
      }
    }

    /// 概要: ログアウトボタンが押された時の処理
    void logout() {
      viewModel.logout();
    }

    ref.listen(authProvider, (previous, next) {
      if (next.isLoggedIn) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ログイン成功')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('ログイン画面')),
      body: switch (state) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        AsyncValue() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('ログイン状態： ${userState}'),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'メールアドレス'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'メールアドレスを入力してください';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return '正しいメールアドレス形式で入力してください';
                          }
                          return null;
                        },
                        onChanged: viewModel.updateEmail,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: 'パスワード'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'パスワードを入力してください';
                          }
                          if (value.length < 6) {
                            return '6文字以上で入力してください';
                          }
                          return null;
                        },
                        onChanged: viewModel.updatePassword,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: login,
                            child: const Text('ログイン'),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                            onPressed: authState.isLoggedIn ? logout : null,
                            child: const Text('ログアウト'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
      },
    );
  }
}
