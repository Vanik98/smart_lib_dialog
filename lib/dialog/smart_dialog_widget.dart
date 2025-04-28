import 'package:flutter/material.dart';
import 'package:smart_lib_dialog/dialog/smart_dialog_params.dart';
import '../base/utils/back_inspector_mixin.dart';

class SmartDialogWidget extends StatefulWidget {
  final SmartDialogParams? dialogParams;

  const SmartDialogWidget({
    super.key,
    this.dialogParams
  });

  @override
  State<StatefulWidget> createState() => _SmartDialogErrorWidgetState();
}

class _SmartDialogErrorWidgetState extends State<SmartDialogWidget> with BackInspector {
  @override
  void initState() {
    super.initState();
    addInspector();
  }

  @override
  void dispose() {
    removeInspector();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final params = widget.dialogParams;
    return GestureDetector(
      onTap: (){
        params?.onOutClick?.call();
      },
      child: Container(
        color: params?.foregroundColor ?? Colors.white.withOpacity(0.8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: params?.backgroundColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: params?.borderColor ?? Colors.grey.shade400,
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (params?.title != null && params!.title!.isNotEmpty && params.onOnClose != null) const SizedBox(width: 48),
                        if (params?.title != null && params!.title!.isNotEmpty)
                          Expanded(
                            child: Center(
                              child: Text(
                                params.title!,
                                style: params.titleTextStyle ?? TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        if(params?.onOnClose != null)IconButton(
                          onPressed: params?.onOnClose,
                          icon: Icon(Icons.close, color: params?.closeIconColor),
                        ),
                      ],
                    ),
                    if (params?.description != null && params!.description!.isNotEmpty)
                      Text(
                        params.description!,
                        style: params.descriptionTextStyle,
                      ),
                    if (params?.customWidget != null) params!.customWidget!,
                    if (params?.positiveButtonText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: FilledButton(
                          onPressed: params?.onPositiveButtonPressed,
                          style: params?.positiveButtonStyle,
                          child: Text(params!.positiveButtonText!,style: params.positiveButtonTextStyle),
                        ),
                      ),
                    if (params?.negativeButtonText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: FilledButton(
                          onPressed: params?.onNegativeButtonPressed,
                          style: params?.negativeButtonStyle,
                          child: Text(params!.negativeButtonText!,style: params.negativeButtonTextStyle,),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
