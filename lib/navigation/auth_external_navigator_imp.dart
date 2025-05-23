import 'package:auth/navigation/navigator.dart';
import 'package:example/router/router.dart';
import 'package:example/router/router.gr.dart';

class AuthExternalNavigatorImpl extends AuthExternalNavigator {
  final AppRouter appRouter;

  AuthExternalNavigatorImpl({required this.appRouter});

  @override
  void navigateToMainScreen() {
    appRouter.replaceAll([
      MainRoute(children: [
        //! Таким образом можно открыть таб навигацию сразу с перезодом в таб More
        // MoreRoute(),
      ])
    ]);
  }
}
