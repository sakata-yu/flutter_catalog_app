import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../data/map_state.dart';

final StateNotifierProvider<MapViewModel, MapState> mapViewModelProvider =
    StateNotifierProvider<MapViewModel, MapState>((Ref ref) => MapViewModel());

class MapViewModel extends StateNotifier<MapState> {
  MapViewModel() : super(const MapState());

  /// 現在位置情報をStateに保存する関数
  ///
  /// Parameters:
  /// - [position] 説明: 現在位置が入ったLatLng
  ///
  void setCurrentPosition(LatLng position) {
    state = state.copyWith(currentPosition: position);
  }
}
