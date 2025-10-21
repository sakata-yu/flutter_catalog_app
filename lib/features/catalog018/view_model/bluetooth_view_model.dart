import 'dart:async';
import 'dart:convert';

import 'package:catalog_app_flutter/features/catalog018/data/ble_device.dart';
import 'package:catalog_app_flutter/features/catalog018/data/bluetooth_chat_message.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/bluetooth_page_state.dart';

final StateNotifierProvider<BluetoothViewModel, BluetoothPageState>
    bluetoothViewModelProvider =
    StateNotifierProvider<BluetoothViewModel, BluetoothPageState>(
        (Ref ref) => BluetoothViewModel());

class BluetoothViewModel extends StateNotifier<BluetoothPageState> {
  BluetoothViewModel() : super(const BluetoothPageState());

  StreamSubscription<List<ScanResult>>? scanSubscription;
  StreamSubscription<List<int>>? notifySubscription;

  Future<void> startScan(
      {Duration timeout = const Duration(seconds: 5)}) async {
    if (state.isScanning) return;
    state = state.copyWith(isScanning: true, devices: <BleDevice>[]);

    try {
      await FlutterBluePlus.startScan(timeout: timeout);
      scanSubscription =
          FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
        final List<BleDevice> devices = results
            .where((ScanResult scanResult) =>
                scanResult.advertisementData.connectable)
            .map((ScanResult scanResult) {
          return BleDevice(
            device: scanResult.device,
            name: scanResult.device.platformName.isNotEmpty
                ? scanResult.device.platformName
                : scanResult.device.remoteId.toString(),
          );
        }).toList();
        state = state.copyWith(devices: devices);
      });
    } catch (e) {
      state = state.copyWith(isScanning: false);
    } finally {
      Future<void>.delayed(timeout, () {
        state = state.copyWith(isScanning: false);
        FlutterBluePlus.stopScan();
      });
    }
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
    scanSubscription?.cancel();
    state = state.copyWith(isScanning: false);
  }

  Future<void> connectToDevice(BleDevice device) async {
    try {
      await device.device?.connect(license: License.free);

      state = state.copyWith(connectedDevice: device);

      final List<BluetoothService> services =
          await device.device?.discoverServices() ?? <BluetoothService>[];

      for (final BluetoothService service in services) {
        for (final BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.notify) {
            await characteristic.setNotifyValue(true);
            notifySubscription =
                characteristic.lastValueStream.listen((List<int> bytes) {
              final String text = utf8.decode(bytes);
              final BluetoothChatMessage newMessage = BluetoothChatMessage(
                message: text,
                isSentByMe: false,
                timestamp: DateTime.now(),
              );
              state = state.copyWith(messages: <BluetoothChatMessage>[
                ...state.messages,
                newMessage,
              ]);
            });
            break;
          }
        }
      }
    } catch (e) {
      state = state.copyWith(isScanning: false);
    }
  }

  Future<void> sendMessage(String message) async {
    if (state.connectedDevice == null) return;

    final BleDevice? device = state.connectedDevice;

    if (device == null) return;

    final List<BluetoothService> services =
        await state.connectedDevice?.device?.discoverServices() ??
            <BluetoothService>[];
    for (final BluetoothService service in services) {
      for (final BluetoothCharacteristic characteristic
          in service.characteristics) {
        if (characteristic.properties.write) {
          await characteristic.write(utf8.encode(message));
          final BluetoothChatMessage newMessage = BluetoothChatMessage(
            message: message,
            isSentByMe: true,
            timestamp: DateTime.now(),
          );
          state = state.copyWith(messages: <BluetoothChatMessage>[
            ...state.messages,
            newMessage,
          ]);
          return;
        }
      }
    }
  }

  Future<void> disconnect() async {
    notifySubscription?.cancel();
    await state.connectedDevice?.device?.disconnect();
    state = const BluetoothPageState();
  }
}
