import 'package:auto_route/auto_route.dart' as ar;
import 'package:flutter/material.dart';
import 'package:navigation_observer/navigation_observer.dart';

/// Адаптер над [NavigationObserver], позволяющий использовать его в routeConfig
/// с использованием библиотеки auto_route.
/// Адаптер позволяет регестрировать как события [Navigator] ([didPush], [didPop]),
/// так и события, характерные только для auto_route - [didInitTabRoute], [didChangeTabRoute].
/// Оба последних события вызывают [NavigationObserver.didPush]
class AutoRouteNavigationObserver extends ar.AutoRouterObserver {
  final NavigationObserver observer;

  AutoRouteNavigationObserver(this.observer);

  @override
  void didPush(Route route, Route? previousRoute) {
    final previousRouteData =
        previousRoute == null ? null : NavigationRouteData.fromRoute(previousRoute);
    observer.didPush(NavigationRouteData.fromRoute(route), previousRouteData);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final previousRouteData =
        previousRoute == null ? null : NavigationRouteData.fromRoute(previousRoute);
    observer.didPop(NavigationRouteData.fromRoute(route), previousRouteData);
  }

  @override
  void didInitTabRoute(ar.TabPageRoute route, ar.TabPageRoute? previousRoute) {
    final previousRouteData =
        previousRoute == null ? null : NavigationRouteData.fromTabRoute(previousRoute);
    observer.didPush(NavigationRouteData.fromTabRoute(route), previousRouteData);
  }

  @override
  void didChangeTabRoute(ar.TabPageRoute route, ar.TabPageRoute previousRoute) {
    observer.didPush(
      NavigationRouteData.fromTabRoute(route),
      NavigationRouteData.fromTabRoute(previousRoute),
    );
  }
}
