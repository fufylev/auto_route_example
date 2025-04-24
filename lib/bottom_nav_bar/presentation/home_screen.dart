import 'package:auto_route/auto_route.dart';
import 'package:common/di/get_it_extensions.dart';
import 'package:example/bottom_nav_bar/navigation/navigator.dart';
import 'package:flutter/material.dart';

import 'navigation_bar.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TabNavigator navigator;

  void _showCloseAppBottomSheet() {
    // final colors = context.theme.extension<UiColors>();
    // showUiModalBottomSheet(
    //   context: context,
    //   useRootNavigator: true,
    //   barrierColor: colors?.backgroundDefault.withOpacity(0.7),
    //   builder: (_) => const CloseAppBottomSheet(),
    // );
  }

  void _onPopInvoked(_, __) {
    final hasNavigated = navigator.tabPop();
    if (!hasNavigated) {
      _showCloseAppBottomSheet();
    }
  }

  @override
  void initState() {
    super.initState();

    navigator = getIt();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvoked,
      child: SafeArea(
        top: false,
        child: AutoTabsScaffold(
          animationDuration: Duration.zero,
          extendBody: true,
          routes: navigator.tabNavigationRoutes,
          inheritNavigatorObservers: true,
          bottomNavigationBuilder: (_, tabsRouter) {
            List<BottomNavigationIndex> indexes = List.of(BottomNavigationIndex.values);

            //! Вот так можно динамически удалить/добавить таб из представления
            // if (some condition) {
            //   indexes.remove(BottomNavigationIndex.more);
            //   indexes.add(BottomNavigationIndex.more);
            // }

            return AppNavigationBar(
              activeIndex: BottomNavigationIndex.values[tabsRouter.activeIndex],
              onTap: (index) {
                tabsRouter.setActiveIndex(index.index);
                navigator.onTabPressed(index);
              },
              indexes: indexes,
            );
          },
        ),
      ),
    );
  }
}
