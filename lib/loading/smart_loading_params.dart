import 'package:flutter/cupertino.dart';

/// Configuration for customizing loading indicator appearance.
///
/// Used with [SmartDialogManager.showLoading] to define the visual
/// properties of a loading dialog.
class SmartLoadingParams {
  /// Optional custom icon to display during loading (default: spinning refresh icon).
  final Icon? icon;

  /// Background color of the loading overlay (default: white).
  final Color? backgroundColor;

  /// Creates a [SmartLoadingParams] instance.
  ///
  /// Both parameters are optional:
  /// - [icon]: Custom loading icon (default: spinning refresh icon)
  /// - [backgroundColor]: Overlay background color (default: white)
  SmartLoadingParams({this.icon, this.backgroundColor});

  /// Creates a new instance with updated values.
  ///
  /// Returns a new [SmartLoadingParams] with the updated fields.
  SmartLoadingParams copyWith({Icon? icon, Color? backgroundColor}) {
    return SmartLoadingParams(
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}