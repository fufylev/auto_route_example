import 'package:auth/di/auth_di_module.dart';
import 'package:auth/navigation/navigator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:example/main/navigation/navigator.dart';
import 'package:example/navigation/auth_external_navigator_imp.dart';
import 'package:example/navigation/home_external_navigator_imp.dart';
import 'package:example/navigation/more_external_navigator_imp.dart';
import 'package:example/router/router.dart';
import 'package:get_it/get_it.dart';
import 'package:home/di/home_di_module.dart';
import 'package:home/navigation/navigator.dart';
import 'package:more/di/more_di_module.dart';
import 'package:more/navigation/navigator.dart';
import 'package:navigation_observer/navigation_observer.dart';

Future<void> initDI() async {
  try {
    final instance = GetIt.instance;
    final _rootRouter = AppRouter();
    final _observer = NavigationObserver();

    /// Этим роутером будем пользоваться в рутовой папке
    instance.registerSingleton<AppRouter>(_rootRouter);

    /// Этим роутером будем пользоваться в модулях
    instance.registerSingleton<StackRouter>(_rootRouter);

    /// Табнавигатором будем управлять переход между главными экранами
    instance.registerSingleton<TabNavigator>(TabNavigator(instance.get()));

    /// Позволяет подписаться на эвенты навигации
    instance.registerSingleton<NavigationObserver>(_observer);

    instance.registerSingleton<AuthExternalNavigator>(AuthExternalNavigatorImpl(appRouter: instance.get()));
    instance.registerSingleton<HomeExternalNavigator>(HomeExternalNavigatorImpl(
      appRouter: instance.get(),
      tabNavigator: instance.get(),
    ));
    instance.registerSingleton<MoreExternalNavigator>(MoreExternalNavigatorImpl(
      appRouter: instance.get(),
      tabNavigator: instance.get(),
    ));

    instance.installModule(AuthDiModule());
    instance.installModule(HomeDiModule());
    instance.installModule(MoreDiModule());
  } catch (e) {
    // TODO
  }
}
