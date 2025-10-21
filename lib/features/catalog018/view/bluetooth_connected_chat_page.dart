import 'package:catalog_app_flutter/features/catalog018/data/ble_device.dart';
import 'package:catalog_app_flutter/features/catalog018/data/bluetooth_chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BluetoothConnectedChatPage extends StatelessWidget {
  const BluetoothConnectedChatPage({
    super.key,
    required this.connectedDevice,
    required this.messages,
    required this.onClickSendMessage,
    required this.onClickDisconnect,
  });

  final BleDevice connectedDevice;
  final List<BluetoothChatMessage> messages;
  final Function(String message) onClickSendMessage;
  final Function() onClickDisconnect;

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('接続端末：${connectedDevice.name}'),
        actions: <Widget>[
          IconButton(
            onPressed: () => onClickDisconnect,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final BluetoothChatMessage message = messages[index];
                return Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          message.isSentByMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message.message,
                      style: TextStyle(
                          color:
                              message.isSentByMe ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Row(
            children: <Widget>[
              Expanded(child: TextField(controller: messageController)),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final String text = messageController.text.trim();
                  if (text.isNotEmpty) {
                    onClickSendMessage(text);
                    messageController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
