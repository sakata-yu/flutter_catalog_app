import 'package:catalog_app_flutter/core/network/response/mock_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<MockChatApi> mockChatApiProvider =
    Provider<MockChatApi>((Ref ref) {
  return MockChatApi();
});

class MockChatApi {
  final List<MockMessage> messages = <MockMessage>[];

  int count = 0;

  Future<List<MockMessage>> fetchMessages() async {
    await Future<void>.delayed(const Duration(milliseconds: 3000));

    // 3秒ごとに1件新しいメッセージを追加
    count++;
    messages.add(
      MockMessage(
        id: DateTime.now().toIso8601String(),
        message: 'メッセージ $count',
        timestamp: DateTime.now(),
      ),
    );

    return List<MockMessage>.unmodifiable(messages);
  }
}
