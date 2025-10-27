import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestBluetoothPermission() async {
  if (Platform.isAndroid) {
    final Map<Permission, PermissionStatus> status = await <Permission>[
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();

    return status[Permission.bluetoothScan]?.isGranted == true &&
        status[Permission.bluetoothConnect]?.isGranted == true;
  }

  // iOSでは常に許可
  return true;
}
