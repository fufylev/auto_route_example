import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(generateForDir: ['modules/account_details/lib'], replaceInRouteName: 'Screen|Page|View|Widget,Route')
class AuthorizationModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [];
}
