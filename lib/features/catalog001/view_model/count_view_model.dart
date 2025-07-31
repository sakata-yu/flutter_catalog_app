import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/count_state.dart';

final countViewModelProvider =
    StateNotifierProvider<CountViewModel, CountState>(
        (ref) => CountViewModel());

class CountViewModel extends StateNotifier<CountState> {
  CountViewModel() : super(const CountState(count: 0));

  /// 概要: カウントを増やす関数
  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  /// 概要: カウントを減らす関数
  void decrement() {
    state = state.copyWith(count: state.count - 1);
  }

  /// 概要: カウントをリセットする関数
  void reset() {
    state = state.copyWith(count: 0);
  }
}
