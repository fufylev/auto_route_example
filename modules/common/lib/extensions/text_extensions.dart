import 'dart:math';

extension RbtStringExtensions on String {
  /// Меняет первую букву в преложении на заглавную
  /// print("0 процентов".firstLetterToUpperCase()); => "0 процентов"
  /// print("маленькая буква".firstLetterToUpperCase()); => "Маленькая буква"
  /// print("- хитрая строка".firstLetterToUpperCase()); => "- хитрая строка"
  String firstLetterToUpperCase() {
    if (isNotEmpty) {
      final firstLetter = this[0].toUpperCase();
      final remains = length > 1 ? substring(1) : '';
      return '$firstLetter$remains';
    } else {
      return this;
    }
  }

  /// Удаляет из строки все символы кроме цифр
  String toDigitString() {
    return replaceAll(RegExp(r"\D"), "");
  }

  /// Преобразует "c2b_payment" или "C2B_PAYMENT" в "C2bPayment"
  /// print("c2b_payment".snakeOrConstantCaseToCamelCase()); => C2bPayment
  /// print("C2B_PAYMENT".snakeOrConstantCaseToCamelCase()); => C2bPayment
  String snakeOrConstantCaseToCamelCase() {
    final divided = split('_');
    final result = [];

    for (var i = 0; i < divided.length; i++) {
      final str = divided[i].toLowerCase();
      final firstLetter = str.isNotEmpty ? str[0] : '';
      final remainedPart = str.length > 1 ? str.substring(1) : '';
      result.add('${i == 0 ? firstLetter : firstLetter.toUpperCase()}$remainedPart');
    }

    return result.join();
  }

  /// Преобразует "C2bPayment" в "c2b_payment"
  /// print("C2bPayment".camelCaseToSnakeCase()); => c2b_payment
  String camelCaseToSnakeCase() {
    return split('').map((e) => e.replaceAll(RegExp(r'[A-Z]'), '_${e.toLowerCase()}')).join();
  }

  /// Преобразует "c2b_payment" в "C2B_PAYMENT"
  /// print("C2bPayment".camelCaseToSnakeCase()); => C2B_PAYMENT
  String camelCaseToConstantCase() {
    return split('')
        .map((e) => e.replaceAll(RegExp(r'[A-Z]'), '_${e.toLowerCase()}'))
        .join()
        .toUpperCase();
  }

  /// Преобразует "199245.12" в "199 245"
  /// print("199245.12".splitDoubleBySize(3)); => 199 245
  /// Преобразует "19245.1" в "19 245.10" при условии removeFloatingPart = true
  /// print("19245.1".splitDoubleBySize(3, removeFloatingPart: false)); => 19 245.10
  /// Преобразует "1245" в "1 245.00" при условии removeFloatingPart = true
  /// print("1245".splitDoubleBySize(3, removeFloatingPart: false)); => 1 245.00
  String splitDoubleBySize(int size, {bool removeFloatingPart = true}) {
    final chunks = [];
    final parts = split('.');
    final floatingPart =
        '.${(parts.length == 1 ? '' : parts.last).padRight(2, '0')}'; // дробная чать
    final intPart = parts.first.split(''); // целая часть

    // Разбиваем на разряды
    for (var i = intPart.length; i > 0; i -= size) {
      final s = intPart.sublist(max(i - size, 0), min(i, intPart.length));
      chunks.add(s);
    }

    return chunks.reversed.map((e) => e.join('')).join(' ') +
        (removeFloatingPart ? '' : floatingPart);
  }

  // https://regex101.com/r/ZwE9j8/1
  /// Убирает все знаки после запятой
  String removeFloatingPart() {
    return replaceAll(RegExp(r"(?:(\.\d*?[1-9]+)|\.)0*$"), "");
  }
}
