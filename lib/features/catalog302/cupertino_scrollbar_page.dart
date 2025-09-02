import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CupertinoScrollbarPage extends StatelessWidget {
  const CupertinoScrollbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 18,
            color: CupertinoColors.label, // iOS標準の文字色
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none, // 下線なし
          ),
        ),
      ),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('CupertinoScrollbar + BouncingScrollPhysics'),
        ),
        child: SafeArea(
          child: CupertinoScrollbar(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(), // iOS風の反発スクロール
              itemCount: 50,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: CupertinoColors.separator),
                    ),
                  ),
                  child: Text(
                    'アイテム $index',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
