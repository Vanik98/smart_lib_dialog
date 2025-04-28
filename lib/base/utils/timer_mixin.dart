import 'dart:async';

mixin TimerMixin {
  Timer? _timer;

  void startTimer(Duration duration, Function() onTimeout) {
    cancelTimer();
    _timer = Timer(duration, onTimeout);
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}