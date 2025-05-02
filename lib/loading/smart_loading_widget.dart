import 'package:flutter/material.dart';
import 'package:smart_lib_dialog/loading/smart_loading_params.dart';

/// A customizable loading indicator dialog with animated spinner.
///
/// Displays a full-screen overlay with a rotating loading icon that can be
/// customized through [SmartLoadingParams].
class SmartLoadingWidget extends StatefulWidget {
  /// Configuration for the loading indicator's appearance.
  final SmartLoadingParams? loadingParams;

  /// Creates a loading dialog with optional custom styling.
  ///
  /// The [loadingParams] parameter controls:
  /// - Background color via [SmartLoadingParams.backgroundColor]
  /// - Custom icon via [SmartLoadingParams.icon]
  const SmartLoadingWidget({super.key, this.loadingParams});

  @override
  State<SmartLoadingWidget> createState() => _SmartLoadingWidgetState();
}

class _SmartLoadingWidgetState extends State<SmartLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Create and start infinite rotation animation
    _controller = AnimationController(
      vsync: this, // Required for animation timing
      duration: const Duration(seconds: 1), // Full rotation duration
    )..repeat(); // Start continuous rotation
  }

  @override
  Widget build(BuildContext context) {
    final params = widget.loadingParams;

    return Stack(
      children: [
        // Fullscreen background overlay
        GestureDetector(
          child: Container(
            color: params?.backgroundColor ?? Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        // Centered loading indicator
        Center(
          child: RotationTransition(
            // Spinning animation using rotation turns
            turns: _controller,
            child: params?.icon ?? const Icon(Icons.refresh, size: 35),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up animation resources
    _controller.dispose();
    super.dispose();
  }
}