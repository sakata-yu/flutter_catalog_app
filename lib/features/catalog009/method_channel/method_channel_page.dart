import 'package:catalog_app_flutter/core/utils/biometric_channel.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MethodChannelPage extends HookConsumerWidget {
  const MethodChannelPage({super.key});

  Future<void> runAuthenticate(
    BuildContext context,
    Widget Function(String title) snackbarContent,
  ) async {
    try {
      final bool result =
          await BiometricChannel.authenticate(reason: 'Flutterからの生体認証呼び出し');
      final String resultMessage = result ? '生体認証に成功しました' : '生体認証に失敗しました';
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: snackbarContent(resultMessage),
        ),
      );
    } on PlatformException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('生体認証を利用できません'),
              Text(e.message ?? ''),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('MethodChannelを使ったOS依存生体認証')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => runAuthenticate(
            context,
            (String title) => Text(title),
          ),
          child: Text(
            '生体認証呼び出し',
            style: textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
