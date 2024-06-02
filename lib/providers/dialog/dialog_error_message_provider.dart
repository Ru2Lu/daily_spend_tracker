import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dialog_error_message_provider.g.dart';

@riverpod
class DialogErrorMessage extends _$DialogErrorMessage {
  @override
  String? build() => null;

  void setDialogErrorMessage(String? dialogErrorMessage) {
    state = dialogErrorMessage;
  }

  void clearDialogErrorMessage() {
    state = null;
  }
}
