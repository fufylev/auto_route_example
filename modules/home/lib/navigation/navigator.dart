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
  /// Произойдет навигация на внешний экран AccountDetails c перекрытием ботом навигации
  void navigateToAccountDetailsScreen() {}

  /// Произойдет прыжок на таб More
  void jumpToMoreScreen() {}

  /// Произойдет прыжок на таб More c открытием внутреннего экрана Intenal без накрытия ботом навигации
  void jumpToMoreScreenAndInternalScreen() {}
}

abstract interface class HomeInternalNavigator {
  /// Произойдет навигация на внутренний экран Intenal без накрытия ботом навигации
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

/// Наследуемся от AtbRouteObserver чтобы иметь возможность использовать [RouteSelector]
class HomeNavigatorImpl extends AtbRouteObserver implements HomeNavigator {
  final HomeExternalNavigator externalNavigator;
  final HomeInternalNavigator internalNavigator;
  final NavigationObserver navigationObserver;

  HomeNavigatorImpl({
    required this.internalNavigator,
    required this.externalNavigator,
    required this.navigationObserver,
  });

  // Создаём пустой колбек который далее будет использоваться как тригер
  VoidCallback didPopListener = () {};

  /// Переопределяем метод [didPop] где перечисляем на какие селектора мы реагируем
  /// При этом это может быть имя роута в другом модуле просто через String
  /// Например "AccountDetailsScreen"
  @override
  void didPop(NavigationRouteData route, NavigationRouteData? previousRoute) {
    // Если то имя роута совпадает с искомым значение то вызываем колбек
    if (route.name == HomeInternalRoute.name) {
      didPopListener.call();
    }
  }

  /// Переопределяем геттер [selectors] где перечисляем на какие селектора мы реагируем
  @override
  List<RouteSelector> get selectors => [
        RouteNameSelector(HomeInternalRoute.name),
      ];

  /// Реагируем на событие навигации
  @override
  void listenDidPop(VoidCallback listener) {
    // присваиваем колбек
    didPopListener = listener;
    // Регистрируем обзервер в нашем классе [NavigationObserver]
    navigationObserver.register(this);
  }

  @override
  void unregisterListener() {
    // Очищаем колбек
    didPopListener = () {};
    // Удаляем обзервер
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
