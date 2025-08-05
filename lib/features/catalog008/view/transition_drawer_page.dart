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
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("NavigationDrawer"),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text("メニュー"),
                ),
                ListTile(
                  title: Text("ホーム"),
                  onTap: () => tapDrawerItem(TransitionHomeRoute()),
                ),
                ListTile(
                  title: Text("お知らせ"),
                  onTap: () => tapDrawerItem(TransitionNoticeRoute()),
                ),
                ListTile(
                  title: Text("マイページ"),
                  onTap: () => tapDrawerItem(TransitionMyRoute()),
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
