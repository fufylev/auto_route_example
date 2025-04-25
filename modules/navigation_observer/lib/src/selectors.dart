import 'package:navigation_observer/src/route_data.dart';

/// базовый селектор для обсервера, имплементации должны реализовать [triggered] метод
abstract class RouteSelector {
  bool triggered(NavigationRouteData route, NavigationRouteData? previousRoute);
}

/// селектор для определенного имени роута, необходимо определить [route]
///
///
/// Пример:
///
/// Определение селектора:
/// ```dart
/// RouteNameSelector(MainScreenRoute.name)
/// ```
/// Поведение
/// ```
/// AnyRoute -> MainScreenRoute -> AnyOtherRoute
///           ^                   ^
///           |                   |
///     triggered(didPush)    triggered(didPop)
/// ```
/// Для более точной настройки можно добавить [previousRoute]
///
/// Определение селектора:
/// ```dart
/// RouteNameSelector(MainScreenRoute.name, CardDetailsRoute.name)
/// ```
/// Поведение
/// ```
/// AnyRoute -> MainScreenRoute -> CardDetailsRoute -> MainScreenRoute
///                             ^                   ^
///                             |                   |
///                      triggered(didPush)     triggered(didPop)
/// ```
class RouteNameSelector implements RouteSelector {
  final String? previousRoute;

  final String route;

  RouteNameSelector(this.route, [this.previousRoute]);

  @override
  bool triggered(NavigationRouteData route, NavigationRouteData? previousRoute) {
    if (this.previousRoute != null) {
      return this.route == route.name && this.previousRoute == previousRoute?.name ||
          this.route == previousRoute?.name && this.previousRoute == route.name;
    }
    return this.route == route.name || this.route == previousRoute?.name;
  }
}

/// Селектор, срабатывающий только на push переданного [routeName]
class PushRouteNameSelector implements RouteSelector {
  final String routeName;

  PushRouteNameSelector(this.routeName);

  @override
  bool triggered(NavigationRouteData route, NavigationRouteData? previousRoute) =>
      routeName == route.name;
}

/// Селектор, для обработки всех событий навигации
class AlwaysSelector implements RouteSelector {
  @override
  bool triggered(NavigationRouteData route, NavigationRouteData? previousRoute) => true;
}
