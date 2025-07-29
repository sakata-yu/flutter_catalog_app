import 'package:flutter/material.dart';

class SimpleBottomSheet extends StatelessWidget {
  const SimpleBottomSheet({
    super.key,
    required this.onOkPressed,
    required this.onCancelPressed,
  });

  final VoidCallback onOkPressed;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "タイトル",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text(
            "コンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツコンテンツ",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  onCancelPressed();
                },
                child: Text("キャンセル"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  onOkPressed();
                },
                child: Text("OK"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
