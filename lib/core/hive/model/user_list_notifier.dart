import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'user.dart';

class UserListNotifier extends StateNotifier<List<User>> {
  UserListNotifier(this.box) : super(box.values.toList());

  final Box<User> box;

  void addUser(User user) {
    box.add(user);
    state = box.values.toList();
  }

  void deleteUser(User user) {
    box.delete(user.key);
    state = box.values.toList();
  }

  void updateUser(
    User user, {
    int? key,
  }) {
    if (key != null) {
      box.put(key, user);
    } else {
      box.put(user.key, user);
    }
    state = box.values.toList();
  }
}
