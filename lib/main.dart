import 'package:common/common.dart';
import 'package:example/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_observer/navigation_observer.dart';

import 'di/init_di.dart';
//ignore_for_file: public_member_api_docs

void main() async {
  await initDI();

  runApp(MyApp(
    appRouter: getIt(),
    observer: getIt(),
  ));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  final NavigationObserver observer;

  const MyApp({super.key, required this.appRouter, required this.observer});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appLifecycleState = WidgetsBinding.instance.lifecycleState;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final AppRouter router = widget.appRouter;
    final NavigationObserver observer = widget.observer;
    return MaterialApp.router(
      routerConfig: router.config(
        navigatorObservers: () => [
          AutoRouteNavigationObserver(observer),
        ],
      ),
      theme: ThemeData.light(),
      builder: (_, router) {
        return router ?? SizedBox.shrink();
      },
      onNavigationNotification: (notification) {
        return _onNavigationNotification(notification);
      },
    );
  }

  bool _onNavigationNotification(NavigationNotification notification) {
    switch (_appLifecycleState) {
      case null:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        // Avoid updating the engine when the app isn't ready.
        return true;
      case AppLifecycleState.resumed:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        SystemNavigator.setFrameworkHandlesBack(widget.appRouter.canNavigateBack);
        return true;
    }
  }
}
