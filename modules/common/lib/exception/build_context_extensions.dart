import 'package:common/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension MediaQueryExt on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// True if the current device is Phone.
  bool get isPhone => mediaQueryShortestSide < 600;

  /// 600dp: a 7” tablet (600x1024 mdpi).
  bool get isSmallTablet => mediaQueryShortestSide >= 600;

  /// 720dp: a 10” tablet (720x1280 mdpi, 800x1280 mdpi, etc).
  bool get isLargeTablet => mediaQueryShortestSide >= 720;

  /// True if the current device is Tablet.
  bool get isTablet => isSmallTablet || isLargeTablet;

  /// Коэффициент отношения ширины девайса к ширине экрана из фигмы
  double get widthFactor => mediaQuerySize.width / Constants.screenWidthFromFigma;

  /// Коэффициент отношения высоты девайса к высоте экрана из фигмы
  double get heightFactor => mediaQuerySize.height / Constants.screenHeightFromFigma;
}

extension NavigatorExt on BuildContext {
  // Future<T?> push<T>(Route<T> route) => Navigator.push(this, route);

  void pop<T extends Object>([T? result]) => Navigator.pop(this, result);

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.pushNamed<T?>(this, routeName, arguments: arguments);

  bool canPop() => Navigator.canPop(this);

  // void popUntil(RoutePredicate predicate) => Navigator.popUntil(this, predicate);
}

extension GoRouterX on GoRouter {
  void maybePop() {
    if (routerDelegate.canPop()) {
      routerDelegate.pop();
    }
  }

  /// Pops all routes until only the root route remains.
  void popUntilRoot() {
    while (_canPopToRoot()) {
      pop();
    }
  }

  /// Checks if we can pop and haven't reached the root yet.
  bool _canPopToRoot() {
    if (!canPop()) return false;

    final currentRoutes = routerDelegate.currentConfiguration;

    return currentRoutes.matches.length > 1; // Если больше 1 маршрута — можно pop
  }

  /// Pops until reaching the root route or a specific route.
  void popUntil({String? targetRoute}) {
    while (_canPopFurther(targetRoute: targetRoute)) {
      pop();
    }
  }

  /// Checks if we can pop further towards the target.
  bool _canPopFurther({String? targetRoute}) {
    if (!canPop()) return false;

    final currentRoutes = routerDelegate.currentConfiguration.matches;
    final isAtRoot = currentRoutes.length <= 1;
    final isAtTarget = targetRoute != null && currentRoutes.last.matchedLocation == targetRoute;

    return !isAtRoot && !isAtTarget;
  }
}

extension BuildContextExtension on BuildContext {
  /// Аналог `popUntilRoot()` из auto_route.
  void popUntilRoot() {
    final router = GoRouter.of(this);
    router.popUntilRoot();
  }

  void maybePop() {
    final router = GoRouter.of(this);
    router.maybePop();
  }

  /// Дополнительно: расширенный метод с поддержкой targetRoute.
  void popUntil({String? targetRoute}) {
    final router = GoRouter.of(this);
    router.popUntil(targetRoute: targetRoute);
  }
}

extension ScaffoldExt on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackbar,
  ) =>
      ScaffoldMessenger.of(this).showSnackBar(snackbar);

  void removeCurrentSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.remove,
  }) =>
      ScaffoldMessenger.of(this).removeCurrentSnackBar(reason: reason);

  void hideCurrentSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.hide,
  }) =>
      ScaffoldMessenger.of(this).hideCurrentSnackBar(reason: reason);

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();
}

class _Form {
  final BuildContext _context;

  _Form(this._context);

  bool validate() => Form.of(_context).validate();
  void reset() => Form.of(_context).reset();
  void save() => Form.of(_context).save();
}

extension FormExt on BuildContext {
  _Form get form => _Form(this);
}

class _FocusScope {
  final BuildContext _context;

  bool get hasFocus => _node().hasFocus;

  bool get isFirstFocus => _node().isFirstFocus;

  bool get hasPrimaryFocus => _node().hasPrimaryFocus;

  bool get canRequestFocus => _node().canRequestFocus;

  const _FocusScope(this._context);

  void nextFocus() => _node().nextFocus();

  void requestFocus([FocusNode? node]) => _node().requestFocus(node);

  void previousFocus() => _node().previousFocus();

  void unfocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) =>
      _node().unfocus(disposition: disposition);

  void setFirstFocus(FocusScopeNode scope) => _node().setFirstFocus(scope);

  bool consumeKeyboardToken() => _node().consumeKeyboardToken();
  FocusScopeNode _node() => FocusScope.of(_context);
}

extension FocusScopeExt on BuildContext {
  _FocusScope get focusScope => _FocusScope(this);

  void closeKeyboard() => focusScope.requestFocus(FocusNode());
}

extension ModalRouteExt<T> on BuildContext {
  ModalRoute<T>? get modalRoute => ModalRoute.of<T>(this);

  RouteSettings? get routeSettings => modalRoute?.settings;
}
