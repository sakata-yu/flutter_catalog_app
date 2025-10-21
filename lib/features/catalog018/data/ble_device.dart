import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_device.freezed.dart';

@freezed
abstract class BleDevice with _$BleDevice {
  factory BleDevice({
    BluetoothDevice? device,
    @Default('') String name,
  }) = _BleDevice;
}
