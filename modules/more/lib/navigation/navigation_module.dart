import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(generateForDir: ['modules/more/lib'], replaceInRouteName: 'Screen|Page|View,Route')
class AuthorizationModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [];
}
