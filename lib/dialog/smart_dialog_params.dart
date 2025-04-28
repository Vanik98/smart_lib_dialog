import 'package:flutter/material.dart';

class SmartDialogParams {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final String? title;
  final TextStyle? titleTextStyle;
  final Color? closeIconColor;
  final TextStyle? descriptionTextStyle;
  final TextStyle? positiveButtonTextStyle;
  final ButtonStyle? positiveButtonStyle;
  final TextStyle? negativeButtonTextStyle;
  final ButtonStyle? negativeButtonStyle;
  final String? description;
  final Widget? customWidget;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositiveButtonPressed;
  final VoidCallback? onNegativeButtonPressed;
  final VoidCallback? onOutClick;
  final VoidCallback? onOnClose;

  SmartDialogParams({this.borderColor, this.titleTextStyle, this.closeIconColor, this.descriptionTextStyle, this.positiveButtonTextStyle, this.positiveButtonStyle, this.negativeButtonTextStyle, this.negativeButtonStyle, this.backgroundColor, this.foregroundColor, this.title, this.description, this.customWidget, this.positiveButtonText, this.negativeButtonText, this.onPositiveButtonPressed, this.onNegativeButtonPressed, this.onOutClick, this.onOnClose});

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
