import 'package:flutter/material.dart';

class MaskedTextEditingController extends TextEditingController {
  String _mask;
  final TextStyle? maskStyle;

  MaskedTextEditingController({required String mask, this.maskStyle, String? text})
      : _mask = mask,
        super(text: text);

  @override

  /// Builds [TextSpan] from current editing value.
  ///
  /// By default makes text in composing range appear as underlined. Descendants
  /// can override this method to customize appearance of text.
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);
    final effectiveMaskStyle = maskStyle ?? Theme.of(context).inputDecorationTheme.hintStyle;
    if (!value.isComposingRangeValid || !withComposing) {
      return TextSpan(style: style, children: [
        TextSpan(text: text),
        if (text.length < mask.length && text.isNotEmpty)
          TextSpan(text: mask.substring(text.length), style: effectiveMaskStyle)
      ]);
    }
    final TextStyle composingStyle = style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
        const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(text: value.composing.textAfter(value.text)),
        if (text.length < mask.length && text.isNotEmpty)
          TextSpan(text: mask.substring(text.length), style: effectiveMaskStyle)
      ],
    );
  }

  String get mask => _mask;

  set mask(String value) {
    if (value == _mask) {
      return;
    }
    _mask = value;
    notifyListeners();
  }
}
