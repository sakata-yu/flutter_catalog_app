import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/camera_state.dart';

final cameraViewModelProvider =
    StateNotifierProvider<CameraViewModel, CameraState>(
        (ref) => CameraViewModel());

class CameraViewModel extends StateNotifier<CameraState> {
  CameraViewModel() : super(const CameraState());

  /// カメラ設定用ControllerをStateに保存する関数
  ///
  /// Parameters:
  /// - [controller] 説明: カメラ設定情報が入ったcontroller
  ///
  void initializeCamera(CameraController? controller) {
    if (controller == null) return;
    state = state.copyWith(
      cameraController: controller,
      imagePath: "",
    );
  }

  /// 撮影した画像のパス情報をStateに保存する関数
  ///
  /// Parameters:
  /// - [imagePath] 説明: 撮影した画像のパス
  ///
  void takePicture(String imagePath) {
    state = state.copyWith(
      imagePath: imagePath,
    );
  }

  /// 画面を離れる際にコントローラーをdisposeし、初期化する関数
  void disposeController() {
    state.cameraController?.dispose();
    state = state.copyWith(cameraController: null);
  }
}
