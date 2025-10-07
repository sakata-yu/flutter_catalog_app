import 'package:catalog_app_flutter/core/hive/hive_provider.dart';
import 'package:catalog_app_flutter/core/hive/model/user.dart';
import 'package:catalog_app_flutter/core/hive/model/user_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view/hive_user_input_dialog.dart';

@RoutePage()
class HivePage extends HookConsumerWidget {
  const HivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<User> users = ref.watch(userListProvider);
    final UserListNotifier userNotifier = ref.read(userListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Hive')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final User? result = await HiveUserInputDialog.show(context);
          if (result != null) {
            userNotifier.addUser(result);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          final User user = users[index];
          return Dismissible(
            key: ValueKey<User>(user),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => userNotifier.deleteUser(user),
            child: ListTile(
              title: Text(user.name),
              subtitle: Text('${user.age}歳'),
              onTap: () async {
                final User? result = await HiveUserInputDialog.show(
                  context,
                  user: user,
                );
                if (result != null) {
                  userNotifier.updateUser(result, key: user.key);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
