import 'package:hive_ce_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User({required this.name, required this.age});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;
}
