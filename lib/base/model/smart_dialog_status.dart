typedef SmartDialogStatusCallback = void Function(SmartDialogStatusEnum status);

enum SmartDialogStatusEnum {
  show,
  dismiss,
}
