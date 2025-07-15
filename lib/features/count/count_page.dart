import 'package:catarog_app_flutter/features/count/view/counter_text.dart';
import 'package:catarog_app_flutter/features/count/view_model/count_view_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// -------------------------------------------------------------------------
/// 機能名: #1 カウントアプリ
///
/// 概要:
/// - シンプルなカウントアプリです
/// - 最小構成のアーキテクチャで作成しています
///
/// 実装内容:
/// - +ボタンでカウントアップ
/// - -ボタンでカウントダウン
/// - Resetボタンでカウントを0に
///
/// 関連ファイル:
/// - `lib/features/count/view/counter_text.dart`: カウンターUIの定義
/// - `lib/features/count/data/count_state.dart`: 状態定義 (freezedなど)
/// - `lib/features/count/view_model/count_view_model.dart`: 状態管理
///
/// -------------------------------------------------------------------------

@RoutePage()
class CountPage extends HookConsumerWidget {
  const CountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(countViewModelProvider);
    final viewModel = ref.read(countViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("#1 カウントアプリ"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterText(count: state.count),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => viewModel.increment(),
                child: Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: () => viewModel.decrement(),
                child: Icon(Icons.remove),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => viewModel.reset(),
            child: Text("Reset"),
          ),
        ],
      ),
    );
  }
}
