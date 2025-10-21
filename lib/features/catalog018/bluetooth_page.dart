import 'package:catalog_app_flutter/core/utils/permission_utils.dart';
import 'package:catalog_app_flutter/features/catalog018/data/ble_device.dart';
import 'package:catalog_app_flutter/features/catalog018/data/bluetooth_page_state.dart';
import 'package:catalog_app_flutter/features/catalog018/view/bluetooth_connected_chat_page.dart';
import 'package:catalog_app_flutter/features/catalog018/view/bluetooth_search_device_page.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view_model/bluetooth_view_model.dart';

@RoutePage()
class BluetoothPage extends HookConsumerWidget {
  const BluetoothPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BluetoothPageState state = ref.watch(bluetoothViewModelProvider);
    final BluetoothViewModel viewModel =
        ref.read(bluetoothViewModelProvider.notifier);

    useEffect(() {
      Future<void> requestPermission() async {
        final bool granted = await requestBluetoothPermission();
        if (context.mounted && !granted) {
          context.router.pop();
        }
      }
      requestPermission();

      return null;
    }, const <Object?>[]);

    return state.connectedDevice == null
        ? BluetoothSearchDevicePage(
            devices: state.devices,
            isScanning: state.isScanning,
            onClickSearch: () => viewModel.startScan(),
            onClickConnect: (BleDevice device) {
              viewModel.stopScan();
              viewModel.connectToDevice(device);
            },
          )
        : BluetoothConnectedChatPage(
            connectedDevice: state.connectedDevice!,
            messages: state.messages,
            onClickSendMessage: (String message) =>
                viewModel.sendMessage(message),
            onClickDisconnect: () => viewModel.disconnect(),
          );
  }
}
