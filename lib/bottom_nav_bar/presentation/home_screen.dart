import 'package:auto_route/auto_route.dart';
import 'package:common/di/get_it_extensions.dart';
import 'package:example/bottom_nav_bar/navigation/navigator.dart';
import 'package:flutter/material.dart';

import 'close_app_bottom_sheet/close_app_bottom_sheet.dart';
import 'navigation_bar.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TabNavigator tabNavigator;

  void _showCloseAppBottomSheet() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (_) => const CloseAppBottomSheet(),
    );
  }

  void _onPopInvoked(_, __) {
    final hasNavigated = tabNavigator.tabPop();
    if (!hasNavigated) {
      _showCloseAppBottomSheet();
    }
  }

  @override
  void initState() {
    super.initState();

    tabNavigator = getIt();
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
          routes: tabNavigator.tabNavigationRoutes,
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
                tabNavigator.onTabPressed(index);
              },
              indexes: indexes,
            );
          },
        ),
      ),
    );
  }
}
