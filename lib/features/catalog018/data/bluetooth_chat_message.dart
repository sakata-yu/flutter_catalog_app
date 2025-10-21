import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_chat_message.freezed.dart';

@freezed
abstract class BluetoothChatMessage with _$BluetoothChatMessage {
  factory BluetoothChatMessage({
    @Default('') String message,
    @Default(false) bool isSentByMe,
    DateTime? timestamp,
  }) = _BluetoothChatMessage;
}
