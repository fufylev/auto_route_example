import 'package:common/localization/localized_extension.dart';
import 'package:flutter/material.dart';

mixin LocalizedWidget<T, P extends StatefulWidget> on State<P> {
  late T localization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final foundedLocale = getLocalization(context);
    localization = foundedLocale.checkLocalization();
  }

  T? getLocalization(BuildContext context);
}
