import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ResponsivePage extends HookConsumerWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('レスポンシブUI')),
      body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        final bool isPortrait = orientation == Orientation.portrait;

        return Center(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            final Image image = Image.network(
              isPortrait
                  ? 'https://placehold.jp/3d4070/ffffff/150x150.png?text=%E7%B8%A6%E5%90%91%E3%81%8D%E3%81%A7%E3%81%99'
                  : 'https://placehold.jp/3d4070/ffffff/150x150.png?text=%E6%A8%AA%E5%90%91%E3%81%8D%E3%81%A7%E3%81%99',
              width: isPortrait
                  ? constraints.maxWidth * 0.6
                  : constraints.maxWidth * 0.3,
            );

            const Padding text = Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'これはサンプルテキストです。画面の向きによってレイアウトが切り替わります。',
                style: TextStyle(fontSize: 18),
              ),
            );

            final Padding screenWidthText = Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '画面の横幅: $screenWidth',
                style: const TextStyle(fontSize: 18),
              ),
            );

            final Padding screenHeightText = Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '画面の横幅: $screenHeight',
                style: const TextStyle(fontSize: 18),
              ),
            );

            return isPortrait
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      image,
                      text,
                      screenWidthText,
                      screenHeightText,
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      image,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text,
                          screenWidthText,
                          screenHeightText,
                        ],
                      ),
                    ],
                  );
          }),
        );
      }),
    );
  }
}
