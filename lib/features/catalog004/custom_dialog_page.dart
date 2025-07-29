import 'package:catarog_app_flutter/features/catalog004/view/simple_bottom_sheet.dart';
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
        title: Text(
          "ダイアログ系ウィジェット",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("スナックバーを表示しました"),
                    action: SnackBarAction(
                      label: "アクション",
                      onPressed: () => {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("スナックバーアクションが実行されました"),
                          ),
                        ),
                      },
                    ),
                  ),
                );
              },
              child: Text(
                "スナックバー表示",
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => AndroidAlertDialog(),
                );
                if (result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("OKが押されました"),
                    ),
                  );
                } else if (!result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("キャンセルが押されました"),
                    ),
                  );
                }
              },
              child: Text(
                "Androidアラートダイアログ表示",
              ),
            ),
          ),
          Center(
            child: CupertinoButton(
              onPressed: () async {
                final result = await showCupertinoDialog(
                  context: context,
                  builder: (context) => IosAlertDialog(),
                );
                if (result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("OKが押されました"),
                    ),
                  );
                } else if (!result && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("キャンセルが押されました"),
                    ),
                  );
                }
              },
              child: Text(
                "iOSアラートダイアログ表示",
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SimpleBottomSheet(
                    onOkPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("OKが押されました"),
                        ),
                      );
                    },
                    onCancelPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("キャンセルが押されました"),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Text(
                "ボトムシート表示",
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Android風トースト",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 16.0,
                );
              },
              child: Text(
                "Android風トースト",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
