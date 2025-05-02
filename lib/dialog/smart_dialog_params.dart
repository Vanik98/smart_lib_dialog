import 'package:flutter/material.dart';

/// Configuration class for customizing dialog appearance and behavior.
///
/// Used with [SmartDialogManager.showDialog] to define the visual and functional
/// properties of a dialog.
class SmartDialogParams {
  /// Background color of the dialog.
  final Color? backgroundColor;

  /// Foreground/text color used in the dialog content.
  final Color? foregroundColor;

  /// Optional border color around the dialog.
  final Color? borderColor;

  /// Optional title text displayed at the top of the dialog.
  final String? title;

  /// Text style for the dialog title.
  final TextStyle? titleTextStyle;

  /// Color of the close icon if shown.
  final Color? closeIconColor;

  /// Text style for the main dialog description.
  final TextStyle? descriptionTextStyle;

  /// Text style for the positive button label.
  final TextStyle? positiveButtonTextStyle;

  /// Button style for the positive button.
  final ButtonStyle? positiveButtonStyle;

  /// Text style for the negative button label.
  final TextStyle? negativeButtonTextStyle;

  /// Button style for the negative button.
  final ButtonStyle? negativeButtonStyle;

  /// Main content message shown in the dialog.
  final String? description;

  /// Custom widget to display instead of the default title/description layout.
  final Widget? customWidget;

  /// Label for the positive action button (e.g., "OK", "Yes").
  final String? positiveButtonText;

  /// Label for the negative action button (e.g., "Cancel", "No").
  final String? negativeButtonText;

  /// Called when the positive button is pressed.
  final VoidCallback? onPositiveButtonPressed;

  /// Called when the negative button is pressed.
  final VoidCallback? onNegativeButtonPressed;

  /// Called when the user clicks outside the dialog.
  final VoidCallback? onOutClick;

  /// Called when the dialog is closed (either via button press or outside click).
  final VoidCallback? onOnClose;

  /// Creates a [SmartDialogParams] instance.
  ///
  /// See [SmartDialogManager.showDialog] for usage.
  SmartDialogParams({this.backgroundColor, this.foregroundColor, this.borderColor, this.title, this.titleTextStyle, this.closeIconColor, this.descriptionTextStyle, this.positiveButtonTextStyle, this.positiveButtonStyle, this.negativeButtonTextStyle, this.negativeButtonStyle, required this.description, this.customWidget, this.positiveButtonText, this.negativeButtonText, this.onPositiveButtonPressed, this.onNegativeButtonPressed, this.onOutClick, this.onOnClose});

  /// Copies this instance with updated values.
  ///
  /// Returns a new [SmartDialogParams] with the updated fields.
  SmartDialogParams copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    String? title,
    TextStyle? titleTextStyle,
    Color? closeIconColor,
    TextStyle? descriptionTextStyle,
    TextStyle? positiveButtonTextStyle,
    ButtonStyle? positiveButtonStyle,
    TextStyle? negativeButtonTextStyle,
    ButtonStyle? negativeButtonStyle,
    String? description,
    Widget? customWidget,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? onPositiveButtonPressed,
    VoidCallback? onNegativeButtonPressed,
    VoidCallback? onOutClick,
    VoidCallback? onOnClose,
  }) {
    return SmartDialogParams(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      title: title ?? this.title,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      positiveButtonTextStyle: positiveButtonTextStyle ?? this.positiveButtonTextStyle,
      positiveButtonStyle: positiveButtonStyle ?? this.positiveButtonStyle,
      negativeButtonTextStyle: negativeButtonTextStyle ?? this.negativeButtonTextStyle,
      negativeButtonStyle: negativeButtonStyle ?? this.negativeButtonStyle,
      description: description ?? this.description,
      customWidget: customWidget ?? this.customWidget,
      positiveButtonText: positiveButtonText ?? this.positiveButtonText,
      negativeButtonText: negativeButtonText ?? this.negativeButtonText,
      onPositiveButtonPressed: onPositiveButtonPressed ?? this.onPositiveButtonPressed,
      onNegativeButtonPressed: onNegativeButtonPressed ?? this.onNegativeButtonPressed,
      onOutClick: onOutClick ?? this.onOutClick,
      onOnClose: onOnClose ?? this.onOnClose,
    );
  }
}
