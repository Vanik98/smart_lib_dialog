import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_lib_dialog/dialog/smart_dialog_params.dart';
import 'package:smart_lib_dialog/dialog/smart_dialog_widget.dart';
import 'package:smart_lib_dialog/loading/smart_loading_params.dart';

import 'base/model/smart_dialog_status.dart';
import 'base/utils/overlay_mixin.dart';
import 'base/utils/status_callback_mixin.dart';
import 'base/utils/timer_mixin.dart';
import 'base/widgets/flutter_easy_dialog_widget.dart';
import 'loading/smart_loading_widget.dart';

/// A singleton manager for displaying global dialogs and loading indicators in Flutter.
///
/// This class provides a unified way to show:
/// - Confirmation dialogs with customizable appearance and actions
/// - Loading indicators with optional animation customization
/// - Custom widgets as modal dialogs
///
/// Key Features:
/// - Show dialogs from anywhere without requiring BuildContext
/// - Auto-dismiss functionality with customizable duration
/// - Global status callbacks for dialog lifecycle tracking
/// - Support for default styling through initialization parameters
class SmartDialogManager with StatusCallbackMixin, TimerMixin, OverlayMixin {
  // Singleton implementation
  SmartDialogManager._internal() : _displayDuration = const Duration(seconds: 10);

  /// Private singleton instance
  static final SmartDialogManager _instance = SmartDialogManager._internal();

  /// Factory constructor to get the singleton instance
  factory SmartDialogManager() => _instance;

  // Internal state management
  late Duration _displayDuration;
  SmartDialogParams? _smartDialogParams;
  SmartLoadingParams? _smartLoadingParams;
  Widget? _widget;

  /// Gets the singleton instance
  static SmartDialogManager get instance => _instance;

  /// Checks if a dialog or loading indicator is currently displayed
  static bool get isShowing => _instance._widget != null;

  /// Gets the currently displayed widget (dialog or loading indicator)
  Widget? get currentWidget => _widget;

  /// Initializes the dialog manager with global configuration
  ///
  /// [builder] Optional custom transition builder for overlay customization
  /// [displayDuration] Default auto-dismiss duration (seconds)
  /// [smartDialogParams] Default styling for dialogs
  /// [smartLoadingParams] Default styling for loading indicators
  ///
  /// Returns a TransitionBuilder that should be used in MaterialApp.builder
  static TransitionBuilder init({
    TransitionBuilder? builder,
    Duration? displayDuration,
    SmartDialogParams? smartDialogParams,
    SmartLoadingParams? smartLoadingParams,
  }) {
    if (displayDuration != null) {
      _instance._displayDuration = displayDuration;
    }
    if (smartDialogParams != null) {
      _instance._smartDialogParams = smartDialogParams;
    }

    if (smartLoadingParams != null) {
      _instance._smartLoadingParams = smartLoadingParams;
    }

    return (BuildContext context, Widget? child) {
      Widget widget = FlutterSmartDialog(child: child);
      if (builder != null) {
        widget = builder(context, widget);
      }
      return widget;
    };
  }

  /// Displays a custom widget as a modal dialog
  ///
  /// [customWidget] Required widget to display
  /// [duration] Optional auto-dismiss duration
  static Future<void> showCustomDialog({required Widget customWidget, Duration? duration}) {
    return _instance._show(widget: customWidget, duration: duration);
  }

  /// Displays a confirmation dialog with customizable content and actions
  ///
  /// [duration] Optional auto-dismiss duration
  /// [params] Dialog configuration including:
  ///   - Title/description text and styles
  ///   - Button labels and styles
  ///   - Callback actions for buttons and dismiss events
  ///   - Custom widget content
  /// [isClosable] Whether the dialog can be closed by tapping outside (default: true)
  static Future<void> showDialog({
    Duration? duration,
    SmartDialogParams? params,
    bool isClosable = true,
  }) {
    final dialogWidget = SmartDialogWidget(
      dialogParams:
      _instance._smartDialogParams?.copyWith(
        backgroundColor: params?.backgroundColor,
        foregroundColor: params?.foregroundColor,
        borderColor: params?.borderColor,
        title: params?.title,
        titleTextStyle: params?.titleTextStyle,
        closeIconColor: params?.closeIconColor,
        descriptionTextStyle: params?.descriptionTextStyle,
        positiveButtonTextStyle: params?.positiveButtonTextStyle,
        positiveButtonStyle: params?.positiveButtonStyle,
        negativeButtonTextStyle: params?.negativeButtonTextStyle,
        negativeButtonStyle: params?.negativeButtonStyle,
        description: params?.description,
        customWidget: params?.customWidget,
        positiveButtonText: params?.positiveButtonText,
        negativeButtonText: params?.negativeButtonText,
        onPositiveButtonPressed: params?.onPositiveButtonPressed ?? dismiss,
        onNegativeButtonPressed: params?.onNegativeButtonPressed ?? dismiss,
        onOutClick: isClosable ? dismiss : (){},
        onOnClose: params?.onOnClose,
      ) ??
          params?.copyWith( onOutClick: isClosable ? dismiss : (){}),
    );

    return _instance._show(widget: dialogWidget, duration: duration);
  }

  /// Displays a loading indicator
  ///
  /// [duration] Optional auto-dismiss duration
  /// [params] Loading indicator configuration including:
  ///   - Custom icon
  ///   - Background color
  static Future<void> showLoading({Duration? duration, SmartLoadingParams? params}) {
    final loadingWidget = SmartLoadingWidget(
      loadingParams: _instance._smartLoadingParams?.copyWith(
          icon: params?.icon, backgroundColor: params?.backgroundColor) ??
          params,
    );
    return _instance._show(widget: loadingWidget, duration: duration);
  }

  /// Dismisses the currently displayed dialog or loading indicator
  static Future<void> dismiss() {
    _instance.cancelTimer();
    return _instance._dismiss();
  }

  /// Internal method to show a widget with optional auto-dismiss
  Future<void> _show({required Widget widget, Duration? duration}) async {
    _widget = widget;
    markNeedsBuild();

    if (widget is SmartLoadingWidget || duration != null) {
      startTimer(duration ?? _displayDuration, () async {
        await dismiss();
      });
    }
  }

  /// Internal method to hide the current widget
  Future<void> _dismiss() async {
    _reset();
  }

  /// Internal cleanup method
  void _reset() {
    _widget = null;
    cancelTimer();
    markNeedsBuild();
    callback(SmartDialogStatusEnum.dismiss);
  }
}