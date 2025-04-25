import 'package:account_details/navigation/navigation_module.gr.dart';
import 'package:example/bottom_nav_bar/navigation/navigator.dart';
import 'package:example/router/router.dart';
import 'package:home/navigation/navigation_module.gr.dart';
import 'package:more/navigation/navigator.dart';

class MoreExternalNavigatorImpl extends MoreExternalNavigator {
  final AppRouter appRouter;
  final TabNavigator tabNavigator;

  MoreExternalNavigatorImpl({
    required this.appRouter,
    required this.tabNavigator,
  });

  @override
  void navigateToAccountDetailsScreen() {
    appRouter.push(const AccountDetailsMainRoute());
  }

  @override
  void jumpToHomeScreen() {
    tabNavigator.navigateToIndex(BottomNavigationIndex.home);
  }

  @override
  void jumpToHomeScreenAndInternalScreen() {
    tabNavigator.navigateToIndex(
      BottomNavigationIndex.home,
      children: [HomeInternalRoute()],
      isChildrenExternal: false,
    );
  }

  @override
  void jumpToHomeScreenAndAccountDetails() {
    tabNavigator.navigateToIndex(BottomNavigationIndex.home, children: [AccountDetailsMainRoute()]);
  }
}
