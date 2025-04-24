import 'dart:ui' as ui show PlatformDispatcher;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class AmountFormatter extends TextInputFormatter {

  const AmountFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String locale = ui.PlatformDispatcher.instance.locale.toString();
    var numberFormats = numberFormatSymbols[locale];
    // локали может не быть, как, например, нет локали ru_RU, однако есть ru
    // на такой случай сделаем проверку
    if (numberFormats == null) {
      locale = Intl.shortLocale(locale);
      numberFormats = numberFormatSymbols[locale];
    }

    final String decimalSeparator = numberFormats?.DECIMAL_SEP ?? '';
    final String groupSeparator = numberFormats?.GROUP_SEP ?? '';

    String newValueText = newValue.text;

    if (newValueText.isEmpty) {
      return newValue;
    }

    // регулярка для отлова не чисел
    final notNum = RegExp(r'\D');

    // регулярка для отлова не чисел и не символа разделителя
    final notNumAndDecimalSeparator = RegExp(r'[^\d\' + decimalSeparator + r']');

    // проверим всю строку на наличие дробного делителя и если их какого-то чёрта несколько - берём последний
    // так же проверим отдельно на '.' и ',' при условии, что эти символы не являются делителями групп разрядов
    int decimalSeparatorIndex = newValueText.length;
    final separators = <String> [
      decimalSeparator,
      if ('.' != groupSeparator)
        '.',
      if (',' != groupSeparator)
        ','
    ];
    for (int i = 0; i < newValueText.length; ++i) {
      if (separators.contains(newValueText[i])) {
        decimalSeparatorIndex = i;
      }
    }

    // берём целую часть и удаляем из неё всё лишнее
    String integerPart = newValueText.substring(0, decimalSeparatorIndex);
    integerPart = integerPart.replaceAll(notNum, '');

    // берём дробную часть при наличии заменяем разделитель и удаляем всё лишнее
    String decimalPart = '';
    if (decimalSeparatorIndex < newValueText.length) {
      decimalPart = newValueText.substring(decimalSeparatorIndex);
      decimalPart = decimalSeparator + decimalPart.substring(1, decimalPart.length);
      decimalPart = decimalPart.replaceAll(notNumAndDecimalSeparator, '');
    }

    // если в дробной части больше 3-х знаков вместе разделителем, оставляем первые 3
    if (decimalPart.length > 3) {
      decimalPart = decimalPart.substring(0, 3);
    }

    // строка может состоять только из десятичного разделителя
    // NumberFormat на такое выбросит исключение
    if (integerPart.isEmpty) {
      integerPart = '0';
    }

    newValueText = integerPart + decimalPart;

    /// форматируем
    final newValueDouble = NumberFormat.decimalPattern(locale).parse(newValueText);
    newValueText = NumberFormat.decimalPattern(locale).format(newValueDouble);

    // NumberFormat подтирает дробную часть, если она '.', '.0' и тп, поэтому добавляем дробную часть
    // если её нет
    if (newValueText.split(decimalSeparator).length == 1) {
      newValueText += decimalPart;
    }

    // считаем количество разделителей до позиции курсора в новой строке
    final rightEdgeNew = (newValue.selection.baseOffset - 1).clamp(0, newValueText.length);
    final spaceNum = groupSeparator.allMatches(newValueText.substring(0, rightEdgeNew)).length;

    // считаем количество разделителей до позиции курсора в старой строке
    final rightEdgeOld = (oldValue.selection.baseOffset - 1).clamp(0, oldValue.text.length);
    final spaceNumOldText = groupSeparator.allMatches(oldValue.text.substring(0, rightEdgeOld)).length;

    // разность числа разделителей
    final spaceNumDif = spaceNum - spaceNumOldText;

    // проверяем на выход за границу
    final caretPosition = (newValue.selection.baseOffset + spaceNumDif).clamp(0, newValueText.length);

    return newValue.copyWith(
      text: newValueText,
      selection: TextSelection.fromPosition(TextPosition(offset: caretPosition)),
    );
  }
}
