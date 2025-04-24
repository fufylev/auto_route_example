import 'package:flutter/services.dart';

/// Класс форматтера который добавляет префикс и суффикс для введенного значения
class RbtTextFieldFormatter implements TextInputFormatter {
  /// Текст который подставится перед введенным значением текстового поля
  final String prefix;

  /// Текст который подставится в конце введенного значения текстового поля
  final String suffix;

  RbtTextFieldFormatter({this.prefix = '', this.suffix = ''});

  @override
  TextEditingValue formatEditUpdate(_, TextEditingValue newValue) {
    final start = newValue.text.length >= suffix.length
        ? newValue.text.length - suffix.length
        : newValue.text.length - 1;

    /// вырезаем значения [suffix] из нового значения чтобы оно не дублировалось
    final newValueRemovedSuffix = newValue.text.substring(start, null) == suffix
        ? newValue.text
            .replaceRange(newValue.text.length - suffix.length, null, '')
        : newValue.text;

    /// вырезаем значения [prefix] из нового значения чтобы оно не дублировалось
    final trimmedNewValue = newValueRemovedSuffix.replaceFirst(prefix, '');

    return TextEditingValue(
      /// добавляем [prefix] и [suffix] к значению введенного текста
      text: prefix + trimmedNewValue + suffix,
      selection: TextSelection.collapsed(
        /// вычисляем новый offset с учетом длины [prefix] чтобы положение корретки курсора было корректное -
        /// между последним введенным символом и [suffix]
        offset: trimmedNewValue.length + prefix.length,
        affinity: TextAffinity.downstream,
      ),
      composing: const TextRange(start: -1, end: -1),
    );
  }
}
