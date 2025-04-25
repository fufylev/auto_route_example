import 'package:account_details/navigation/navigator.dart';
import 'package:auth/navigation/navigator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:example/main/navigation/navigator.dart';

@AutoRouterConfig(generateForDir: ['lib'], replaceInRouteName: 'Screen|Page|View|Widget,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    ...AuthRouter.routers, //! Тут в этом роуторе пока жестко задано откуда стартанет приложение
    ...BottomNavBarRouter.routers,
    ...AccountDetailsRouter.routers,
  ];
}
