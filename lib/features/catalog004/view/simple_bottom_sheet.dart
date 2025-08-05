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
        children: <Widget>[
          Text(
            'タイトル',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            '''
            コンテンツコンテンツコンテンツコンテンツコンテンツ
            コンテンツコンテンツコンテンツコンテンツコンテンツ
            コンテンツコンテンツコンテンツコンテンツコンテンツ
            コンテンツコンテンツコンテンツ
            ''',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  onCancelPressed();
                },
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  onOkPressed();
                },
                child: const Text('OK'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
