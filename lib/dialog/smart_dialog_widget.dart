import 'package:flutter/material.dart';
import 'package:smart_lib_dialog/dialog/smart_dialog_params.dart';

import '../base/utils/back_inspector_mixin.dart';

/// A customizable dialog widget that supports title, description, buttons, and custom content.
///
/// This dialog can be displayed globally in the app without requiring a BuildContext,
/// and supports styling through [SmartDialogParams].
class SmartDialogWidget extends StatefulWidget {
  /// Configuration for the dialog's appearance and behavior.
  ///
  /// If null, the dialog may use default styling from [SmartDialogManager.init].
  final SmartDialogParams? dialogParams;

  /// Creates a new SmartDialogWidget with the given configuration.
  ///
  /// The [dialogParams] parameter controls:
  /// - Dialog colors (background, foreground, border)
  /// - Text styles for title/description/buttons
  /// - Button styles and labels
  /// - Callback actions for buttons and dismiss events
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
    // Register this dialog with the back button inspector
    addInspector();
  }

  @override
  void dispose() {
    // Unregister when dialog is disposed
    removeInspector();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final params = widget.dialogParams;

    return GestureDetector(
      // Handle tap outside the dialog to trigger onOutClick callback
      onTap: (){
        if(params?.onOutClick != null){
          params!.onOutClick!();
        }
      },
      child: Container(
        // Fullscreen overlay with semi-transparent background
        color: params?.foregroundColor ?? Colors.white.withOpacity(0.8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: GestureDetector(
              // Prevents taps from propagating to the overlay
              onTap: () {},
              child: Container(
                // Dialog content container with rounded corners
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
                    // Dialog Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Title (centered)
                        if (params?.title != null && params!.title!.isNotEmpty)
                          Expanded(
                            child: Center(
                              child: Text(
                                params.title!,
                                style: params.titleTextStyle ?? const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        // Close button (if provided)
                        if (params?.onOnClose != null) IconButton(
                          onPressed: params?.onOnClose,
                          icon: Icon(Icons.close, color: params?.closeIconColor),
                        ),
                      ],
                    ),

                    // Description Text
                    if (params?.description != null && params!.description!.isNotEmpty)
                      Text(
                        params.description!,
                        style: params.descriptionTextStyle,
                      ),

                    // Custom Widget (if provided)
                    if (params?.customWidget != null) params!.customWidget!,

                    // Positive Action Button
                    if (params?.positiveButtonText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: params?.onPositiveButtonPressed,
                            style: params?.positiveButtonStyle,
                            child: Text(
                              params!.positiveButtonText!,
                              style: params.positiveButtonTextStyle,
                            ),
                          ),
                        ),
                      ),

                    // Negative Action Button
                    if (params?.negativeButtonText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: params?.onNegativeButtonPressed,
                            style: params?.negativeButtonStyle,
                            child: Text(
                              params!.negativeButtonText!,
                              style: params.negativeButtonTextStyle,
                            ),
                          ),
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