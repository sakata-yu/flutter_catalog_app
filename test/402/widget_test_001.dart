// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:catarog_app_flutter/core/config/app_constants.dart';
import 'package:catarog_app_flutter/features/catalog001/count_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  Widget wrap(Widget child) => ProviderScope(
        child: MaterialApp(home: child),
      );

  Future<void> pumpCount(WidgetTester tester) async {
    await tester.pumpWidget(wrap(const CountPage()));
    await tester.pump(); // 初期フレーム反映
  }

  Finder valueText() => find.byKey(AppConstants.countValueText);
  Finder incrementButton() => find.byKey(AppConstants.countIncrementButton);
  Finder decrementButton() => find.byKey(AppConstants.countDecrementButton);
  Finder resetButton() => find.byKey(AppConstants.countResetButton);

  String readValue(WidgetTester tester) =>
      tester.widget<Text>(valueText()).data!;

  testWidgets('Initial value = 0', (WidgetTester tester) async {
    await pumpCount(tester);
    expect(readValue(tester), '0');
  });

  testWidgets('Press "+" button once', (WidgetTester tester) async {
    await pumpCount(tester);

    await tester.tap(incrementButton());
    await tester.pump();

    expect(readValue(tester), '1');
  });

  testWidgets('Press "-" button once', (WidgetTester tester) async {
    await pumpCount(tester);

    await tester.tap(decrementButton());
    await tester.pump();

    expect(readValue(tester), '-1');
  });

  testWidgets('Tap "+" twice, "-" once, and reset once',
      (WidgetTester tester) async {
    await pumpCount(tester);

    await tester.tap(incrementButton());
    await tester.tap(incrementButton());
    await tester.pump();
    expect(readValue(tester), '2');

    await tester.tap(decrementButton());
    await tester.pump();
    expect(readValue(tester), '1');

    await tester.tap(resetButton());
    await tester.pump();
    expect(readValue(tester), '0');
  });
}
