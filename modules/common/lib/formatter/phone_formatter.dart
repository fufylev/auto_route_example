import 'package:common/formatter/mask_text_input_formatter.dart';
import 'package:flutter/services.dart';

const String russianOfficialCode = "7";
const String russianNotOfficialCode = "8";
const String russianStart = "+7 ";
const int firstDividerPosition = 6;
const int secondDividerPosition = 8;
const int phoneLengthWithCode = 11;
const int startPhonePosition = 3;

class PhoneFormatter extends TextInputFormatter {
  final bool useOnlyNumber;

  PhoneFormatter({required this.useOnlyNumber});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!useOnlyNumber && !_isNumeric(newValue.text) && !newValue.text.startsWith('+7')) {
      return TextEditingValue(
          text: newValue.text, selection: TextSelection.collapsed(offset: newValue.text.length));
    }
    if (oldValue.text.isEmpty &&
        (newValue.text.startsWith(russianOfficialCode) ||
            newValue.text.startsWith(russianNotOfficialCode))) {
      var rawString = _clearString(newValue.text);
      final regexp = RegExp(r'^[7-8]{1}$');
      if (regexp.stringMatch(rawString) != null) {
        rawString = russianStart;
      } else {
        rawString = rawString.formatPhoneNumber();
      }
      return TextEditingValue(
          text: rawString, selection: TextSelection.collapsed(offset: rawString.length));
    }

    if (oldValue.text == newValue.text) return newValue;

    final isDeleted = newValue.text.length < oldValue.text.length;
    final oldRawString = _clearString(oldValue.text);
    final rawString = _clearString(newValue.text);

    if (!_isStringValid(rawString)) {
      return oldValue;
    }

    if (rawString.length == 1 &&
        (rawString.contains(russianOfficialCode) || rawString.contains(russianNotOfficialCode))) {
      if (isDeleted) {
        if (oldRawString == rawString) {
          return const TextEditingValue(selection: TextSelection.collapsed(offset: 0));
        }
      }
    }

    if (isDeleted) {
      if (newValue.selection.end < startPhonePosition) {
        return oldValue.copyWith(
            selection: const TextSelection.collapsed(offset: startPhonePosition));
      } else if (oldRawString == rawString) {
        return oldValue.copyWith(
            selection: TextSelection.collapsed(offset: newValue.selection.end));
      }
    }

    final resultString = _buildPhoneNumber(newValue.text);
    if (!isDeleted && resultString == russianStart) {
      return oldValue;
    }

    int selection;
    if (newValue.selection.end == newValue.text.length) {
      selection = resultString.length;
    } else {
      if (newValue.selection.end < startPhonePosition) {
        selection = startPhonePosition + 1;
      } else {
        var offs = resultString.length - newValue.text.length;

        if (offs <= 0) {
          selection = newValue.selection.end;
        } else {
          final oldSubs = newValue.text.substring(0, newValue.selection.end);
          final offString = _buildPhoneNumber(oldSubs);

          selection = offString.length;
        }
      }
    }

    return TextEditingValue(
        text: resultString, selection: TextSelection.collapsed(offset: selection));
  }

  String _clearString(String rawValue) {
    final result = rawValue.replaceAll(RegExp(r'\D'), "");

    return result;
  }

  bool _isStringValid(String rawValue) {
    if (rawValue.length > phoneLengthWithCode) {
      return false;
    }

    final reg = RegExp(r"^[0-9]*$");
    return reg.hasMatch(rawValue);
  }

  String _buildPhoneNumber(String newValue) {
    final StringBuffer newText = StringBuffer();
    int currentPosition = 0;
    var isStartedWithCode = false;

    final rawValue = _clearString(newValue);
    if (newValue.startsWith("+7")) {
      currentPosition++;
      isStartedWithCode = true;
    }

    int firstDividerThreshold = firstDividerPosition;
    int secondDividerThreshold = secondDividerPosition;

    if (isStartedWithCode) {
      firstDividerThreshold++;
      secondDividerThreshold++;
    }

    newText.write(russianStart);
    while (currentPosition < rawValue.length) {
      if (currentPosition == 0 || currentPosition == 1) {
        newText.write("(");
      }
      if (currentPosition == 4) {
        newText.write(") ");
      }
      if (currentPosition == firstDividerThreshold) {
        newText.write("-");
      }
      if (currentPosition == secondDividerThreshold) {
        newText.write("-");
      }
      newText.write(rawValue[currentPosition]);
      currentPosition++;
    }

    final result = newText.toString();
    return result;
  }
}

extension NumberExtension on String {
  String formatPhoneNumber() {
    return MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: {"#": RegExp(r'[0-9]')})
        .formatEditUpdate(
            const TextEditingValue(),
            TextEditingValue(
                text: startsWith("8") ? "7${substring(1)}" : this,
                selection: const TextSelection.collapsed(offset: 100)))
        .text;
  }

  String unMask() {
    return MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: {"#": RegExp(r'[0-9]')})
        .unmaskText(this);
  }

  String addMask() {
    List<String> list = split('');
    List<String> mask = '(***) *** **-**'.split('');

    list.addAll(mask..removeRange(0, list.length - 3));

    return list.join();
  }
}

bool _isNumeric(String s) {
  final str = s
      .replaceAll(' ', '')
      .replaceAll('+', '')
      .replaceAll('-', '')
      .replaceAll('(', '')
      .replaceAll(')', '');
  return double.tryParse(str) != null;
}
