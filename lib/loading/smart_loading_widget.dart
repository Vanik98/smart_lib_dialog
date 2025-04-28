import 'package:flutter/material.dart';
import 'package:smart_lib_dialog/loading/smart_loading_params.dart';


class SmartLoadingWidget extends StatefulWidget {
  final SmartLoadingParams? loadingParams;
  const SmartLoadingWidget({super.key, this.loadingParams});

  @override
  State<SmartLoadingWidget> createState() => _SmartLoadingWidgetState();
}

class _SmartLoadingWidgetState extends State<SmartLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final params = widget.loadingParams;
    return Stack(
      children: [
        GestureDetector(
          child: Container(
            color: params?.backgroundColor ?? Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        //  content
        Center(
          child: RotationTransition(
            turns: _controller,
            child:params?.icon ?? Icon(Icons.refresh,size: 35,),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
