import 'package:auto_route/auto_route.dart';

import 'navigation_module.gr.dart';

class MoreRouter {
  static const String moreRoutePath = 'more';
  static const String moreMainRoutePath = 'more_main';
  static const String moreInternalRoutePath = 'internal';

  static List<AutoRoute> routers = [
    AutoRoute(
      path: moreRoutePath,
      page: MoreRoute.page,
      children: [
        AutoRoute(
          initial: true,
          path: moreMainRoutePath,
          page: MoreMainRoute.page,
        ),
        AutoRoute(
          path: moreInternalRoutePath,
          page: MoreInternalRoute.page,
        ),
      ],
    ),
  ];
}

abstract class MoreExternalNavigator {
  void navigateToAccountDetailsScreen() {}
  void jumpToHomeScreen() {}
  void jumpToHomeScreenAndInternalScreen() {}
}

abstract class MoreInternalNavigator {
  void navigateToInternalScreen() {}
}

class MoreInternalNavigatorImpl implements MoreInternalNavigator {
  // Иcпользуем [StackRouter] из самого пакета auto_route, чтобы не завязываться на родительский [AppRouter]
  // StackRouter нужно будет пробросить в [GetIt] параллельно с [AppRouter]
  final StackRouter router;

  MoreInternalNavigatorImpl({required this.router});

  @override
  void navigateToInternalScreen() {
    router.push(const MoreInternalRoute());
  }
}

abstract class MoreNavigator {
  void navigateToInternalScreen() {}
  void navigateToAccountDetailsScreen() {}
  void jumpToHomeScreen() {}
  void jumpToHomeScreenAndInternalScreen() {}
}

class MoreNavigatorImpl implements MoreNavigator {
  final MoreExternalNavigator externalNavigator;
  final MoreInternalNavigator internalNavigator;

  MoreNavigatorImpl({required this.internalNavigator, required this.externalNavigator});

  @override
  void navigateToInternalScreen() {
    internalNavigator.navigateToInternalScreen();
  }

  @override
  void navigateToAccountDetailsScreen() {
    externalNavigator.navigateToAccountDetailsScreen();
  }

  @override
  void jumpToHomeScreen() {
    externalNavigator.jumpToHomeScreen();
  }

  @override
  void jumpToHomeScreenAndInternalScreen() {
    externalNavigator.jumpToHomeScreenAndInternalScreen();
  }
}
