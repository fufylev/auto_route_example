import 'package:account_details/navigation/navigation_module.gr.dart';
import 'package:example/bottom_nav_bar/navigation/navigator.dart';
import 'package:example/router/router.dart';
import 'package:home/navigation/navigator.dart';
import 'package:more/navigation/navigation_module.gr.dart';

class HomeExternalNavigatorImpl extends HomeExternalNavigator {
  final AppRouter appRouter;
  final TabNavigator tabNavigator;

  HomeExternalNavigatorImpl({
    required this.appRouter,
    required this.tabNavigator,
  });

  @override
  void navigateToAccountDetailsScreen() {
    appRouter.push(const AccountDetailsMainRoute());
  }

  @override
  void jumpToMoreScreen() {
    tabNavigator.navigateToIndex(BottomNavigationIndex.more);
  }

  @override
  void jumpToMoreScreenAndInternalScreen() {
    tabNavigator.navigateToIndexWithNestedScreens(BottomNavigationIndex.more, children: [MoreInternalRoute()]);
  }
}
