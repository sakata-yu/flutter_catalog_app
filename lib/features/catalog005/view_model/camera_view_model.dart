import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/camera_state.dart';

final cameraViewModelProvider =
    StateNotifierProvider<CameraViewModel, CameraState>(
        (ref) => CameraViewModel());

class CameraViewModel extends StateNotifier<CameraState> {
  CameraViewModel() : super(const CameraState());

  void initializeCamera(CameraController? controller) {
    if (controller == null) return;
    state = state.copyWith(
      cameraController: controller,
      imagePath: "",
    );
  }

  void takePicture(String imagePath) {
    state = state.copyWith(
      imagePath: imagePath,
    );
  }

  void disposeController() {
    state.cameraController?.dispose();
    state = state.copyWith(cameraController: null);
  }
}
