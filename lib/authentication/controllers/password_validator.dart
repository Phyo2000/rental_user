import 'dart:math';

import 'package:flutter/services.dart';

class PasswordValidator extends TextInputFormatter {
  static final _passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue;
  }

  @override
  TextEditingValue sanitizeTextEditingValue(TextEditingValue value) {
    final sanitizedText = _passwordRegExp
        .allMatches(value.text)
        .map((match) => match.group(0))
        .join();
    final sanitizedSelection = value.selection.copyWith(
      baseOffset: min(value.selection.start, sanitizedText.length),
      extentOffset: min(value.selection.end, sanitizedText.length),
    );
    return TextEditingValue(
      text: sanitizedText,
      selection: sanitizedSelection,
      composing: TextRange.empty,
    );
  }
}
