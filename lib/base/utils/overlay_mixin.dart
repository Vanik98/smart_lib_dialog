import '../widgets/overlay_entry.dart';

mixin OverlayMixin {
  late SmartDialogOverlayEntry? overlayEntry;

  void initializeOverlayEntry(SmartDialogOverlayEntry entry) {
    overlayEntry = entry;
  }

  void markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }
}