import 'package:common/bloc/base_cubit.dart';
import 'package:example/router/router.dart';
import 'package:flutter/services.dart';

class CloseAppActionCubit extends BaseCubit<CloseAppActionState> {
  final AppRouter router;

  CloseAppActionCubit({
    required this.router,
  }) : super(CloseAppActionState());

  /// Принудительное закрытие приложения
  void exitApp() => _exitApp();

  /// Закрытие модалки
  void closeView() => _closeView();

  void _exitApp() {
    _closeView();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void _closeView() => router.maybePop();
}

class CloseAppActionState {}
