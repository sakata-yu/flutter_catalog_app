import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/count_state.dart';

final countViewModelProvider =
    StateNotifierProvider<CountViewModel, CountState>(
        (ref) => CountViewModel());

class CountViewModel extends StateNotifier<CountState> {
  CountViewModel() : super(const CountState(count: 0));

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void decrement() {
    state = state.copyWith(count: state.count - 1);
  }

  void reset() {
    state = state.copyWith(count: 0);
  }
}
