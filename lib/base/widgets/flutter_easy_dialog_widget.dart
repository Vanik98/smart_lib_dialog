import 'package:flutter/material.dart';

import '../../smart_dialog_manager.dart';
import 'overlay_entry.dart';

/// Root widget that provides overlay context for displaying global dialogs.
///
/// Wraps the application with an [Overlay] to enable showing dialogs and loading
/// indicators from anywhere in the app without requiring a BuildContext.
///
/// This widget must be used as the root of the widget tree when using SmartDialogManager.
class FlutterSmartDialog extends StatefulWidget {
  /// The child widget that represents the main application content.
  final Widget? child;

  /// Creates a FlutterSmartDialog that wraps the application content.
  ///
  /// The [child] parameter is required and represents the main app UI.
  const FlutterSmartDialog({
    super.key,
    required this.child,
  })  : assert(child != null);

  @override
  State createState() => _FlutterSmartDialogState();
}

class _FlutterSmartDialogState extends State<FlutterSmartDialog> {
  late SmartDialogOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();

    // Create and register the overlay entry for dialog display
    _overlayEntry = SmartDialogOverlayEntry(
      builder: (BuildContext context) => SmartDialogManager.instance.currentWidget ?? Container(),
    );

    // Register with SmartDialogManager
    SmartDialogManager.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          // Main application content
          SmartDialogOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          // Dialog overlay entry
          _overlayEntry,
        ],
      ),
    );
  }
}