import 'package:back_button_interceptor/back_button_interceptor.dart';

mixin BackInspector {
  bool _inspector(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  addInspector() => BackButtonInterceptor.add(_inspector);

  removeInspector() => BackButtonInterceptor.remove(_inspector);
}
