import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SmartDialogOverlayEntry extends OverlayEntry {
  SmartDialogOverlayEntry({required super.builder});

  @override
  void markNeedsBuild() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}
