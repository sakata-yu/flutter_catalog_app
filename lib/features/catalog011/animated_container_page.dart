import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AnimatedContainerPage extends HookConsumerWidget {
  const AnimatedContainerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> toggled = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer')),
      body: Center(
        child: GestureDetector(
          onTap: () => toggled.value = !toggled.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: toggled.value ? 100 : 60,
            height: toggled.value ? 100 : 60,
            decoration: BoxDecoration(
              color: toggled.value ? Colors.redAccent : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: toggled.value
                  ? <BoxShadow>[
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 10,
                      )
                    ]
                  : <BoxShadow>[],
            ),
            child: Icon(
              toggled.value ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: toggled.value ? 48 : 30,
            ),
          ),
        ),
      ),
    );
  }
}
