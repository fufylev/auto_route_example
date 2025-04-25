import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:navigation_observer/navigation_observer.dart';

import 'navigation_module.gr.dart';

class HomeRouter {
  static const String homeRoutePath = 'home';
  static const String homeMainRoutePath = 'home_main';
  static const String homeInternalRoutePath = 'internal';

  static List<AutoRoute> routers = [
    AutoRoute(
      path: homeRoutePath,
      page: HomeRoute.page,
      children: [
        AutoRoute(
          initial: true,
          path: homeMainRoutePath,
          page: HomeMainRoute.page,
        ),
        AutoRoute(
          path: homeInternalRoutePath,
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

abstract interface class HomeInternalNavigator {
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

abstract interface class HomeNavigator {
  void navigateToAccountDetailsScreen() {}
  void navigateToInternalScreen() {}
  void jumpToMoreScreen() {}
  void jumpToMoreScreenAndInternalScreen() {}

  void listenDidPop(VoidCallback listener);
  void unregisterListener();
}

class HomeNavigatorImpl extends AtbRouteObserver implements HomeNavigator {
  final HomeExternalNavigator externalNavigator;
  final HomeInternalNavigator internalNavigator;
  final NavigationObserver navigationObserver;

  HomeNavigatorImpl({
    required this.internalNavigator,
    required this.externalNavigator,
    required this.navigationObserver,
  });

  VoidCallback didPopListener = () {};

  @override
  void didPop(NavigationRouteData route, NavigationRouteData? previousRoute) {
    if (route.name == HomeInternalRoute.name) {
      didPopListener.call();
    }
  }

  @override
  List<RouteSelector> get selectors => [
        RouteNameSelector(HomeInternalRoute.name),
      ];

  @override
  void listenDidPop(VoidCallback listener) {
    didPopListener = listener;
    navigationObserver.register(this);
  }

  @override
  void unregisterListener() {
    didPopListener = () {};
    navigationObserver.unregister(this);
  }

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
