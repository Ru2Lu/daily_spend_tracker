import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dialog_controller_provider.g.dart';

@riverpod
class DialogController extends _$DialogController {
  @override
  TextEditingController build() => TextEditingController();
}
