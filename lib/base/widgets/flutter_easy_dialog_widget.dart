import 'package:flutter/material.dart';

import '../../smart_dialog_manager.dart';
import 'overlay_entry.dart';

class FlutterSmartDialog extends StatefulWidget {
  final Widget? child;

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
    _overlayEntry = SmartDialogOverlayEntry(
      builder: (BuildContext context) => SmartDialogManager.instance.currentWidget ?? Container(),
    );
    SmartDialogManager.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          SmartDialogOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}
