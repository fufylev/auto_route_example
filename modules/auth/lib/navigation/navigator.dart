import 'package:auto_route/auto_route.dart';

import 'navigation_module.gr.dart';

class AuthRouter {
  static List<AutoRoute> routers = [
    AutoRoute(
      initial: true, // ! Отсюда стартанет приложение так как этот роут помечен '/' и [initial : true]
      path: '/login',
      page: LoginRoute.page,
    ),
    AutoRoute(
      path: '/pin_code',
      page: PinCodeRoute.page,
    ),
  ];
}

abstract class AuthExternalNavigator {
  void navigateToMainScreen() {}
}

abstract class AuthInternalNavigator {
  void navigateToPinCode() {}
}

class AuthInternalNavigatorImpl implements AuthInternalNavigator {
  // Иcпользуем [StackRouter] из самого пакета auto_route, чтобы не завязываться на родительский [AppRouter]
  // StackRouter нужно будет пробросить в [GetIt] параллельно с [AppRouter]
  final StackRouter router;

  AuthInternalNavigatorImpl({required this.router});

  @override
  void navigateToPinCode() {
    router.push(const PinCodeRoute());
  }
}

abstract class AuthNavigator {
  void navigateToPinCode() {}
  void navigateToMainScreen() {}
}

class AuthNavigatorImpl implements AuthNavigator {
  final AuthExternalNavigator externalNavigator;
  final AuthInternalNavigator internalNavigator;

  AuthNavigatorImpl({required this.internalNavigator, required this.externalNavigator});

  @override
  void navigateToMainScreen() {
    externalNavigator.navigateToMainScreen();
  }

  @override
  void navigateToPinCode() {
    internalNavigator.navigateToPinCode();
  }
}
