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

class SmartDialogManager with StatusCallbackMixin, TimerMixin, OverlayMixin {
  SmartDialogManager._internal() : _displayDuration = const Duration(seconds: 10);

  static final SmartDialogManager _instance = SmartDialogManager._internal();

  factory SmartDialogManager() => _instance;

  late Duration _displayDuration;
  SmartDialogParams? _smartDialogParams;
  SmartLoadingParams? _smartLoadingParams;
  Widget? _widget;

  static SmartDialogManager get instance => _instance;

  static bool get isShowing => _instance._widget != null;

  Widget? get currentWidget => _widget;

  /// Initializes the SmartDialogManager with optional custom settings
  static TransitionBuilder init({TransitionBuilder? builder, Duration? displayDuration, SmartDialogParams? smartDialogParams, SmartLoadingParams? smartLoadingParams}) {
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

  static Future<void> showCustomDialog({required Widget customWidget, Duration? duration}) {
    return _instance._show(widget: customWidget, duration: duration);
  }

  static Future<void> showDialog({Duration? duration, SmartDialogParams? params, bool isClosable = true}) {
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
            onOutClick: isClosable ? dismiss :  params?.onOutClick,
            onOnClose: params?.onOnClose,
          ) ??
          params,
    );

    return _instance._show(widget: dialogWidget, duration: duration);
  }

  /// Shows a loading dialog
  static Future<void> showLoading({Duration? duration, SmartLoadingParams? params}) {
    final loadingWidget = SmartLoadingWidget(loadingParams: _instance._smartLoadingParams?.copyWith(icon: params?.icon, backgroundColor: params?.backgroundColor) ?? params);
    return _instance._show(widget: loadingWidget, duration: duration);
  }

  static Future<void> dismiss() {
    _instance.cancelTimer();
    return _instance._dismiss();
  }

  Future<void> _show({required Widget widget, Duration? duration}) async {
    _widget = widget;
    markNeedsBuild();

    if (widget is SmartLoadingWidget || duration != null) {
      startTimer(duration ?? _displayDuration, () async {
        await dismiss();
      });
    }
  }

  Future<void> _dismiss() async {
    _reset();
  }

  void _reset() {
    _widget = null;
    cancelTimer();
    markNeedsBuild();
    callback(SmartDialogStatusEnum.dismiss);
  }
}
