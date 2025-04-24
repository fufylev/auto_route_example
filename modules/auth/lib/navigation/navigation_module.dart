import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(generateForDir: ['modules/auth/lib'])
class AuthorizationModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [];
}
