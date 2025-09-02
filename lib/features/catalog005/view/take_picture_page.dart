import 'package:camera/camera.dart';
import 'package:catalog_app_flutter/features/catalog005/data/camera_state.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../view_model/camera_view_model.dart';

@RoutePage()
class TakePicturePage extends HookConsumerWidget {
  const TakePicturePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CameraState state = ref.watch(cameraViewModelProvider);
    final CameraViewModel viewModel =
        ref.read(cameraViewModelProvider.notifier);

    /// 概要: カメラを初期化し、バックカメラで撮影できるように設定する関数
    Future<void> initCamera() async {
      final List<CameraDescription> cameras = await availableCameras();
      final CameraDescription backCamera = cameras.firstWhere(
          (CameraDescription camera) =>
              camera.lensDirection == CameraLensDirection.back);
      final CameraController cameraController =
          CameraController(backCamera, ResolutionPreset.medium);
      await cameraController.initialize();
      viewModel.initializeCamera(cameraController);
    }

    /// 概要: 撮影し、撮影画像のパスをStateに保存する関数
    Future<void> takePicture() async {
      final CameraController? controller = state.cameraController;
      if (controller == null || !controller.value.isInitialized) return;
      final XFile image = await controller.takePicture();
      viewModel.takePicture(image.path);
      if (context.mounted) context.router.pop();
    }

    useEffect(() {
      initCamera();

      return null;
    }, <Object?>[]);

    final CameraController? controller = state.cameraController;

    return Scaffold(
      appBar: AppBar(title: const Text('カメラ')),
      body: controller != null && controller.value.isInitialized
          ? Stack(
              children: <Widget>[
                CameraPreview(controller),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                      onPressed: takePicture,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
