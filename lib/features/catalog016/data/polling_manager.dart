class PollingManager {
  PollingManager({
    required this.callback,
    this.intervalSeconds = 10,
  });

  final Function() callback;
  int intervalSeconds;
  bool isRunning = false;

  Future<void> startPolling() async {
    isRunning = true;
    while (isRunning) {
      await callback();
      await Future<void>.delayed(Duration(seconds: intervalSeconds));
    }
  }

  void stopPolling() {
    isRunning = false;
  }
}
