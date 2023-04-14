import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length) {
      if (newValue.text.startsWith('0')) {
        return newValue.copyWith(
          text: '+91${newValue.text.substring(1)}',
          selection:
              TextSelection.collapsed(offset: newValue.selection.end + 3),
        );
      } else if (!newValue.text.startsWith('+91')) {
        return newValue.copyWith(
          text: '+91${newValue.text}',
          selection:
              TextSelection.collapsed(offset: newValue.selection.end + 3),
        );
      }
    }
    return newValue;
  }
}
