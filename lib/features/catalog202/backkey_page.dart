import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class BackkeyPage extends HookConsumerWidget {
  const BackkeyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<BackMode> mode = useState(BackMode.block);
    final ValueNotifier<DateTime?> lastBackPressed = useState(null);

    Future<bool> showConfirmDialog() async {
      final bool? result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('戻る確認'),
          content: const Text('この画面を閉じてもよろしいですか？'),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('キャンセル')),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('OK')),
          ],
        ),
      );
      return result ?? false; // ×や戻るで閉じたら false
    }

    Future<bool> handlePop() async {
      switch (mode.value) {
        case BackMode.block:
          // 完全に戻らせない
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('この画面では戻る操作はできません')),
          );
          return false;

        case BackMode.confirm:
          // ユーザーに確認
          return await showConfirmDialog();

        case BackMode.doubleAction:
          // 2秒以内に2回押しで戻る
          final DateTime now = DateTime.now();
          final DateTime? lastBackPressedValue = lastBackPressed.value;
          if (lastBackPressedValue == null ||
              now.difference(lastBackPressedValue) >
                  const Duration(seconds: 2)) {
            lastBackPressed.value = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('もう一度押すと閉じます')),
            );
            return false;
          }
          return true;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('バックキー制御')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) return;
          final bool allow = await handlePop();
          if (allow && context.mounted) {
            context.router.pop();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<BackMode>(
                    segments: const <ButtonSegment<BackMode>>[
                      ButtonSegment<BackMode>(
                          value: BackMode.block, label: Text('ブロック')),
                      ButtonSegment<BackMode>(
                          value: BackMode.confirm, label: Text('確認')),
                      ButtonSegment<BackMode>(
                          value: BackMode.doubleAction, label: Text('2回押し')),
                    ],
                    selected: <BackMode>{
                      mode.value
                    },
                    onSelectionChanged: (Set<BackMode> set) =>
                        mode.value = set.first),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              switch (mode.value) {
                BackMode.block => '戻るを常に拒否します。',
                BackMode.confirm => '戻る時に確認ダイアログを表示します。',
                BackMode.doubleAction => '2秒以内に2回押すと閉じます。',
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum BackMode {
  block,
  confirm,
  doubleAction,
}
