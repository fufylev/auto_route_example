import 'package:auto_route/auto_route.dart';
import 'package:example/router/router.dart';
import 'package:example/router/router.gr.dart';
import 'package:home/navigation/navigation_module.gr.dart';
import 'package:home/navigation/navigator.dart';
import 'package:more/navigation/navigation_module.gr.dart';
import 'package:more/navigation/navigator.dart';

class BottomNavBarRouter {
  static const String path = '/main';

  static List<AutoRoute> routers = [
    AutoRoute(
      path: path,
      page: MainRoute.page,
      children: [
        ...HomeRouter.routers,
        ...MoreRouter.routers,
      ],
    )
  ];
}

const _routes = [
  HomeRoute(),
  MoreRoute(),
];

enum BottomNavigationIndex {
  home,
  more,
}

class TabNavigator {
  final AppRouter router;
  BottomNavigationIndex? _prevIndex;
  BottomNavigationIndex _currentIndex = BottomNavigationIndex.home;

  TabNavigator(this.router);

  List<PageRouteInfo> get tabNavigationRoutes => _routes;

  /// Метод нужен для кейсов, когда навигация между табами выполняется не нажатием пользователя
  /// на таб, а другими средствами. Например, переход из Home экрана в экран More
  /// Метод выполняет навигацию и обновляет [_currentIndex] и [_prevIndex].
  Future<void> navigateToIndex(
    BottomNavigationIndex newIndex, {
    List<PageRouteInfo> children = const [],
    isChildrenExternal = true,
  }) async {
    _updateCurrentIndex(newIndex);

    if (isChildrenExternal) {
      final tabsRouter = router.innerRouterOf<TabsRouter>(MainRoute.name);
      if (tabsRouter != null) {
        tabsRouter.setActiveIndex(newIndex.index);
        for (var route in children) {
          router.push(route);
        }
      }
    } else {
      final targetRoute = children.isNotEmpty ? _getNestedRoute(_currentIndex, children) : _getRoute(_currentIndex);
      await router.navigate(targetRoute);
    }
  }

  /// Метод обрабатывает нажатия на таб навигации. Обновляет [_currentIndex] и [_prevIndex]
  /// и фиксирует кейсы двойного нажатия на таб.
  void onTabPressed(BottomNavigationIndex newIndex) {
    _updateCurrentIndex(newIndex);
    if (_currentIndex == _prevIndex) {
      final targetRoute = _getRoute(_currentIndex);
      final currentPath = router.currentPath;

      final moreMainPath = '${BottomNavBarRouter.path}/${MoreRouter.moreRoutePath}/${MoreRouter.moreMainRoutePath}';
      final homeMainPath = '${BottomNavBarRouter.path}/${HomeRouter.homeRoutePath}/${HomeRouter.homeMainRoutePath}';

      // Исключаем повторный процесс [router.replaceAll] если на данный момент уже открыт главный экран текущего таба
      // это исключает ненужное перестроение и моргание экрана
      if (currentPath != homeMainPath && newIndex == BottomNavigationIndex.home ||
          currentPath != moreMainPath && newIndex == BottomNavigationIndex.more) {
        // если _currentIndex == _prevIndex значит мы повторно тапаем по одному и тому же табу
        // для таба с [newIndex] производим замену всего стека на "главный для конкретного таба" экран
        router.replaceAll([targetRoute]);
      }
    }
  }

  /// Обработка навигации "назад" для табов. Возвращает bool значение, сообщающее о том
  /// была ли обработана навигация или нет. Навигация не может быть обработана только в том случае
  /// если она вызывается с главного экрана. Этот кейс должен быть обработан в месте вызова.
  /// В ином случае выполняется навигация на главный роут.
  bool tabPop() {
    if (_currentIndex != BottomNavigationIndex.home) {
      _updateCurrentIndex(BottomNavigationIndex.home);
      router.navigate(_routes[0]);
      return true;
    } else {
      return false;
    }
  }

  PageRouteInfo _getRoute(BottomNavigationIndex index) {
    return switch (index) {
      BottomNavigationIndex.home => HomeMainRoute(),
      BottomNavigationIndex.more => MoreMainRoute(),
    };
  }

  PageRouteInfo _getNestedRoute(BottomNavigationIndex index, List<PageRouteInfo> children) {
    return switch (index) {
      BottomNavigationIndex.home => HomeRoute(children: [HomeMainRoute(), ...children]),
      BottomNavigationIndex.more => MoreRoute(children: [MoreMainRoute(), ...children]),
    };
  }

  void _updateCurrentIndex(BottomNavigationIndex newIndex) {
    _prevIndex = _currentIndex;
    _currentIndex = newIndex;
  }
}
