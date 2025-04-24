import 'package:auto_route/auto_route.dart';

import 'navigation_module.gr.dart';

class HomeRouter {
  static List<AutoRoute> routers = [
    AutoRoute(
      path: 'home',
      page: HomeRoute.page,
      children: [
        AutoRoute(
          initial: true,
          path: 'home_main',
          page: HomeMainRoute.page,
          children: [
            AutoRoute(
              path: 'internal',
              page: HomeInternalRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: 'internal',
          page: HomeInternalRoute.page,
        ),
      ],
    ),
  ];
}

abstract class HomeExternalNavigator {
  void navigateToAccountDetailsScreen() {}
  void jumpToMoreScreen() {}
  void jumpToMoreScreenAndInternalScreen() {}
}

abstract class HomeInternalNavigator {
  void navigateToInternalScreen() {}
}

class HomeInternalNavigatorImpl implements HomeInternalNavigator {
  // Иcпользуем [StackRouter] из самого пакета auto_route, чтобы не завязываться на родительский [AppRouter]
  // StackRouter нужно будет пробросить в [GetIt] параллельно с [AppRouter]
  final StackRouter router;

  HomeInternalNavigatorImpl({required this.router});

  @override
  void navigateToInternalScreen() {
    router.push(const HomeInternalRoute());
  }
}

abstract class HomeNavigator {
  void navigateToAccountDetailsScreen() {}
  void navigateToInternalScreen() {}
  void jumpToMoreScreen() {}
  void jumpToMoreScreenAndInternalScreen() {}
}

class HomeNavigatorImpl implements HomeNavigator {
  final HomeExternalNavigator externalNavigator;
  final HomeInternalNavigator internalNavigator;

  HomeNavigatorImpl({required this.internalNavigator, required this.externalNavigator});

  @override
  void navigateToAccountDetailsScreen() {
    externalNavigator.navigateToAccountDetailsScreen();
  }

  @override
  void navigateToInternalScreen() {
    internalNavigator.navigateToInternalScreen();
  }

  @override
  void jumpToMoreScreen() {
    externalNavigator.jumpToMoreScreen();
  }

  @override
  void jumpToMoreScreenAndInternalScreen() {
    externalNavigator.jumpToMoreScreenAndInternalScreen();
  }
}
