import '../model/smart_dialog_status.dart';

mixin StatusCallbackMixin {
  final List<SmartDialogStatusCallback> _statusCallbacks = [];

  void addStatusCallback(SmartDialogStatusCallback callback) {
    if (!_statusCallbacks.contains(callback)) {
      _statusCallbacks.add(callback);
    }
  }

  void removeCallback(SmartDialogStatusCallback callback) {
    if (_statusCallbacks.contains(callback)) {
      _statusCallbacks.remove(callback);
    }
  }

  void removeAllCallbacks() {
    _statusCallbacks.clear();
  }

  void callback(SmartDialogStatusEnum status) {
    for (final SmartDialogStatusCallback callback in _statusCallbacks) {
      callback(status);
    }
  }
}
