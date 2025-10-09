import 'package:freezed_annotation/freezed_annotation.dart';

part 'mock_message.freezed.dart';

@freezed
abstract class MockMessage with _$MockMessage {
  const factory MockMessage({
    @Default('') String id,
    @Default('') String message,
    DateTime? timestamp,
  }) = _MockMessage;
}
