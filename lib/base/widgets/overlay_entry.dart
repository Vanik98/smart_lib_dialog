import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Custom [OverlayEntry] that safely handles widget rebuilds during different scheduler phases.
///
/// This class ensures that dialog updates are scheduled appropriately to avoid
/// framework exceptions when marking overlays as needing rebuild during
/// specific scheduling phases.
class SmartDialogOverlayEntry extends OverlayEntry {
  /// Creates a SmartDialogOverlayEntry with the specified builder function.
  ///
  /// The [builder] parameter is required and defines the widget to display.
  SmartDialogOverlayEntry({required super.builder});

  @override
  void markNeedsBuild() {
    // Special handling to avoid rebuilds during persistent callbacks phase
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      // Schedule rebuild after current frame if in persistent callback phase
      SchedulerBinding.instance.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      // Normal rebuild for other phases
      super.markNeedsBuild();
    }
  }
}