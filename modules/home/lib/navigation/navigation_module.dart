import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(generateForDir: ['modules/home/lib'], replaceInRouteName: 'Screen|Page|View|Widget,Route')
class AuthorizationModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [];
}
