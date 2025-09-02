import 'package:catalog_app_flutter/features/catalog004/view/simple_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'view/android_alert_dialog.dart';
import 'view/ios_alert_dialog.dart';

@RoutePage()
class CustomDialogPage extends HookConsumerWidget {
  const CustomDialogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ダイアログ系ウィジェット',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('スナックバーを表示しました'),
                    action: SnackBarAction(
                      label: 'アクション',
                      onPressed: () => <ScaffoldFeatureController<SnackBar,
                          SnackBarClosedReason>>{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('スナックバーアクションが実行されました'),
                          ),
                        ),
                      },
                    ),
                  ),
                );
              },
              child: const Text(
                'スナックバー表示',
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final bool result = await showDialog(
                  context: context,
                  builder: (BuildContext context) => const AndroidAlertDialog(),
                );
                if (result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('OKが押されました'),
                    ),
                  );
                } else if (!result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('キャンセルが押されました'),
                    ),
                  );
                }
              },
              child: const Text(
                'Androidアラートダイアログ表示',
              ),
            ),
          ),
          Center(
            child: CupertinoButton(
              onPressed: () async {
                final bool result = await showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => const IosAlertDialog(),
                );
                if (result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('OKが押されました'),
                    ),
                  );
                } else if (!result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('キャンセルが押されました'),
                    ),
                  );
                }
              },
              child: const Text(
                'iOSアラートダイアログ表示',
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => SimpleBottomSheet(
                    onOkPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OKが押されました'),
                        ),
                      );
                    },
                    onCancelPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('キャンセルが押されました'),
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Text(
                'ボトムシート表示',
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'Android風トースト',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 16.0,
                );
              },
              child: const Text(
                'Android風トースト',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
