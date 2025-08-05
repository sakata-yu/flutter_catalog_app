import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router/app_router.dart';

@RoutePage()
class TransitionDrawerPage extends StatelessWidget {
  const TransitionDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    void tapDrawerItem(PageRouteInfo route) {
      context.router.pop();
      context.router.replace(route);
    }

    return AutoRouter(
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('NavigationDrawer'),
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                const DrawerHeader(
                  child: Text('メニュー'),
                ),
                ListTile(
                  title: const Text('ホーム'),
                  onTap: () => tapDrawerItem(const TransitionHomeRoute()),
                ),
                ListTile(
                  title: const Text('お知らせ'),
                  onTap: () => tapDrawerItem(const TransitionNoticeRoute()),
                ),
                ListTile(
                  title: const Text('マイページ'),
                  onTap: () => tapDrawerItem(const TransitionMyRoute()),
                ),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
