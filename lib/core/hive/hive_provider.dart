import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'model/user.dart';
import 'model/user_list_notifier.dart';

const String userBox = 'users';

final FutureProvider<void> hiveInitProvider =
    FutureProvider<void>((Ref ref) async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  if (!Hive.isBoxOpen(userBox)) {
    await Hive.openBox<User>(userBox);
  }
});

final StateNotifierProvider<UserListNotifier, List<User>> userListProvider =
    StateNotifierProvider<UserListNotifier, List<User>>((Ref ref) {
  final Box<User> box = Hive.box<User>(userBox);
  return UserListNotifier(box);
});
