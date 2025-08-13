import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class IntentPage extends HookConsumerWidget {
  const IntentPage({super.key});

  void openDialer(String phone) {
    runIfAndroid(() async {
      final AndroidIntent intent = AndroidIntent(
          action: 'android.intent.action.DIAL', data: 'tel:$phone');
      await intent.launch();
    });
  }

  void openMap(double lat, double lng, {String? label}) {
    runIfAndroid(() async {
      final String geo = label == null
          ? 'geo:$lat,$lng'
          : 'geo:$lat,$lng?q=${Uri.encodeComponent(label)}($lat,$lng)';
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        data: geo,
      );
      await intent.launch();
    });
  }

  void openAppSettings() {
    runIfAndroid(() async {
      const AndroidIntent intent = AndroidIntent(
        action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
        data: 'package:com.example.catalog_app_flutter',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    });
  }

  void launchPackage(String packageName) {
    runIfAndroid(() async {
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: packageName,
        category: 'android.intent.category.LAUNCHER',
        flags: <int>[
          Flag.FLAG_ACTIVITY_NEW_TASK,
        ],
      );
      await intent.launch();
    });
  }

  void shareText(String text) {
    runIfAndroid(() async {
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.SEND',
        arguments: <String, dynamic>{'android.intent.extra.TEXT': text},
        type: 'text/plain',
      );
      await intent.launch();
    });
  }

  void runIfAndroid(void Function() action) {
    if (Platform.isAndroid) {
      action();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intentを使った別アプリ起動')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => openDialer('0120345678'),
              child: const Text('ダイヤラを開く'),
            ),
            ElevatedButton(
              onPressed: () => openMap(35.681236, 139.767125, label: '東京駅'),
              child: const Text('地図アプリで東京駅を開く'),
            ),
            ElevatedButton(
              onPressed: openAppSettings,
              child: const Text('このアプリの設定画面を開く'),
            ),
            ElevatedButton(
              onPressed: () => launchPackage('com.google.android.youtube'),
              child: const Text('YouTubeアプリを起動'),
            ),
            ElevatedButton(
              onPressed: () => shareText('これは共有のテキストです'),
              child: const Text('共有シート（IntentChooser）を開く'),
            ),
          ],
        ),
      )
    );
  }
}
