import 'package:catalog_app_flutter/features/catalog018/data/ble_device.dart';
import 'package:catalog_app_flutter/features/catalog018/data/bluetooth_chat_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_page_state.freezed.dart';

@freezed
abstract class BluetoothPageState with _$BluetoothPageState {
  const factory BluetoothPageState({
    @Default(<BluetoothChatMessage>[]) List<BluetoothChatMessage> messages,
    @Default(<BleDevice>[]) List<BleDevice> devices,
    BleDevice? connectedDevice,
    @Default(false) bool isScanning,
  }) = _BluetoothPageState;

}
