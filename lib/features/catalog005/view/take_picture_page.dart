import 'package:camera/camera.dart';
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
    final state = ref.watch(cameraViewModelProvider);
    final viewModel = ref.read(cameraViewModelProvider.notifier);

    Future<void> initCamera() async {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
      final cameraController = CameraController(backCamera, ResolutionPreset.medium);
      await cameraController.initialize();
      viewModel.initializeCamera(cameraController);
    }

    Future<void> takePicture() async {
      final controller = state.cameraController;
      if (controller == null || !controller.value.isInitialized) return;
      final image = await controller.takePicture();
      viewModel.takePicture(image.path);
      if (context.mounted) context.router.pop();
    }

    useEffect(() {
      initCamera();

      return null;
    }, []);

    final controller = state.cameraController;

    return Scaffold(
      appBar: AppBar(title: const Text('カメラ')),
      body: controller != null && controller.value.isInitialized
          ? Stack(
        children: [
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
