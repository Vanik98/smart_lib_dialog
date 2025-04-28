import 'package:flutter/cupertino.dart';

class SmartLoadingParams {
  final Icon? icon;
  final Color? backgroundColor;

  SmartLoadingParams({this.icon, this.backgroundColor});

  SmartLoadingParams copyWith({Icon? icon, Color? backgroundColor}) {
    return SmartLoadingParams(icon: icon ?? this.icon, backgroundColor: backgroundColor ?? this.backgroundColor);
  }
}
