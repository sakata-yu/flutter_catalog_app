import 'package:catalog_app_flutter/features/catalog018/data/ble_device.dart';
import 'package:flutter/material.dart';

class BluetoothSearchDevicePage extends StatelessWidget {
  const BluetoothSearchDevicePage({
    super.key,
    required this.devices,
    required this.isScanning,
    required this.onClickSearch,
    required this.onClickConnect,
  });

  final List<BleDevice> devices;
  final bool isScanning;
  final Function() onClickSearch;
  final Function(BleDevice device) onClickConnect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE デバイス一覧'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: onClickSearch,
            child: isScanning ? const Text('スキャン中...') : const Text('スキャン開始'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (BuildContext context, int index) {
                final BleDevice device = devices[index];
                return ListTile(
                  title: Text(device.name),
                  subtitle: Text('${device.device?.remoteId}'),
                  onTap: () => onClickConnect(device),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
