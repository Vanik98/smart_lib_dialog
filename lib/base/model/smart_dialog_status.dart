/// Callback signature for receiving dialog status updates.
///
/// Used to register listeners that will be notified when the dialog status changes.
/// 
/// Example:
/// ```dart
/// void onDialogStatusChanged(SmartDialogStatusEnum status) {
///   if (status == SmartDialogStatusEnum.show) {
///     print('Dialog is now visible');
///   }
/// }
/// ```
typedef SmartDialogStatusCallback = void Function(SmartDialogStatusEnum status);

/// Enumerates the possible statuses of a dialog managed by SmartDialogManager.
///
/// Used throughout the package to track and respond to dialog lifecycle events.
/// This is particularly useful for implementing status indicators, analytics,
/// or synchronized UI updates based on dialog visibility.
enum SmartDialogStatusEnum {
  /// Indicates that a dialog is being displayed.
  ///
  /// Triggered when:
  /// - A dialog is successfully shown via [SmartDialogManager.showDialog]
  /// - A loading indicator is displayed via [SmartDialogManager.showLoading]
  show,

  /// Indicates that a dialog has been dismissed.
  ///
  /// Triggered when:
  /// - User manually closes the dialog
  /// - Dialog auto-dismisses due to timeout
  /// - Dismiss is called programmatically via [SmartDialogManager.dismiss]
  dismiss,
}