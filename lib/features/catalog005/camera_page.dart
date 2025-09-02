import 'dart:io';

import 'package:catalog_app_flutter/core/router/app_router.dart';
import 'package:catalog_app_flutter/features/catalog005/data/camera_state.dart';
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
    final CameraState state = ref.watch(cameraViewModelProvider);
    final CameraViewModel viewModel =
        ref.read(cameraViewModelProvider.notifier);

    /// 概要: カメラ権限を取得し、カメラ撮影画面に遷移する関数
    Future<void> handleCameraLaunch() async {
      final PermissionStatus status = await Permission.camera.request();
      if (status.isGranted && context.mounted) {
        final String? result = await context.router.push<String>(
          const TakePictureRoute(),
        );
        if (result != null) {
          viewModel.takePicture(result);
        }
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('カメラの使用が許可されていません'),
          ),
        );
      }
    }

    useEffect(() {
      return viewModel.disposeController;
    }, <Object?>[]);

    return Scaffold(
      appBar: AppBar(title: const Text('カメラ')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            onPressed: handleCameraLaunch,
            child: const Text('カメラを起動する'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: state.imagePath.isNotEmpty
                ? Center(
                    child: Image.file(
                      File(state.imagePath),
                    ),
                  )
                : const Center(
                    child: Text(
                      'ここに撮影した画像が表示されます',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
