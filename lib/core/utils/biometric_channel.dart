import 'package:flutter/services.dart';

mixin BiometricChannel {
  static const MethodChannel channel =
      MethodChannel('com.persol.fluttercatalogapp/auth');

  static Future<bool> authenticate({
    String reason = '生体認証',
  }) async =>
      await channel.invokeMethod(
        'authenticate',
        <String, String>{'reason': reason},
      );
}
