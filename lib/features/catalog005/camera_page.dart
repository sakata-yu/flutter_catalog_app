import 'dart:io';

import 'package:catarog_app_flutter/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import 'view_model/camera_view_model.dart';

@RoutePage()
class CameraPage extends HookConsumerWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cameraViewModelProvider);
    final viewModel = ref.read(cameraViewModelProvider.notifier);

    Future<void> handleCameraLaunch() async {
      final status = await Permission.camera.request();
      if (status.isGranted && context.mounted) {
        final result = await context.router.push<String>(
          TakePictureRoute(),
        );
        if (result != null) {
          viewModel.takePicture(result);
        }
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("カメラの使用が許可されていません"),
          ),
        );
      }
    }

    useEffect(() {
      return viewModel.disposeController;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('カメラ')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: handleCameraLaunch,
            child: Text("カメラを起動する"),
          ),
          SizedBox(height: 16),
          Expanded(
            child: state.imagePath.isNotEmpty
                ? Center(
                    child: Image.file(
                      File(state.imagePath),
                    ),
                  )
                : Center(
                    child: Text(
                      "ここに撮影した画像が表示されます",
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
