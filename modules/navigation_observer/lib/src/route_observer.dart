import 'package:navigation_observer/navigation_observer.dart';

/// Класс реализующий обсервер для навигации
///
/// Пример:
/// внутри вашего модуля необходимо объявить абстрактный обсервер реализующий [didPop], [didPush] или [didRemove]
/// ```dart
/// abstract class MainScreenObserver extends RouteObserver {
///  @override
///  void didPop(Route route, Route? previousRoute) {
///    print(route.settings.name);
///  }
/// }
/// ```
///
/// Далее в `lib/observers` добавить реализацию данного класс с необходимыми селекторами
/// см [RouteSelector]
/// ```dart
/// class MainScreenObserverImpl extends RouteObserver {
///   @override
///   List<RouteSelector> get selectors => [RouteNameSelector(MainScreenRoute.name)];
/// }
/// ```
abstract class AtbRouteObserver {
  List<RouteSelector> get selectors;

  /// [route] - Текущий роут с которого ушли
  ///
  /// [previousRoute] - Роут, который сразу под [route] и, следовательно, новый активный
  void didPop(NavigationRouteData route, NavigationRouteData? previousRoute) {}

  /// [route] - Новый роут, который стал активным
  ///
  /// [previousRoute] - Роут, который был активным
  void didPush(NavigationRouteData route, NavigationRouteData? previousRoute) {}

  void didRemove(NavigationRouteData route, NavigationRouteData? previousRoute) {}
}
