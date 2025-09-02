import 'package:catalog_app_flutter/features/catalog004/view/ios_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CupertinoSamplePage extends HookConsumerWidget {
  const CupertinoSamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> sliderValue = useState(false);
    final ValueNotifier<int> selectedSegmentValue = useState(0);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return CupertinoTheme(
      data: const CupertinoThemeData(brightness: Brightness.light),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('iOS風ウィジェット'),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton.filled(
                  child: const Text('Action Sheet'),
                  onPressed: () => showCupertinoModalPopup(
                    context: context,
                    builder: (_) => CupertinoActionSheet(
                      title: const Text('アクション一覧'),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          onPressed: () => context.router.pop(),
                          child: const Text('アクション1'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () => context.router.pop(),
                          child: const Text('アクション2'),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () => context.router.pop(),
                        child: const Text('キャンセル'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoButton.filled(
                  child: const Text('日付ピッカー'),
                  onPressed: () => showCupertinoModalPopup(
                    context: context,
                    builder: (_) => Container(
                      height: 300,
                      color:
                          CupertinoColors.systemBackground.resolveFrom(context),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (DateTime newDateTime) {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Switch',
                      style: textTheme.titleMedium,
                    ),
                    CupertinoSwitch(
                      value: sliderValue.value,
                      onChanged: (bool value) {
                        sliderValue.value = value;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CupertinoSegmentedControl<int>(
                  groupValue: selectedSegmentValue.value,
                  onValueChanged: (int value) {
                    selectedSegmentValue.value = value;
                  },
                  children: <int, Widget>{
                    0: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'ホーム',
                        style: textTheme.titleMedium,
                      ),
                    ),
                    1: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '検索',
                        style: textTheme.titleMedium,
                      ),
                    ),
                    2: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '設定',
                        style: textTheme.titleMedium,
                      ),
                    ),
                  },
                ),
                const SizedBox(height: 16),
                CupertinoButton.filled(
                  child: const Text('ダイアログ表示'),
                  onPressed: () => showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) => const IosAlertDialog(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
