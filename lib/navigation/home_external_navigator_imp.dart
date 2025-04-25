import 'package:account_details/navigation/navigation_module.gr.dart';
import 'package:example/main/navigation/navigator.dart';
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
    //! Тут может возникнуть соблазн сделать сразу вот так: ```appRouter.navigateTo(const MoreMainRoute());```
    //! но тогда наш TabNavigator не будет знать текущий индекс, аналогично и по ниже указанным методам
  }

  @override
  void jumpToMoreScreenAndInternalScreen() {
    tabNavigator.navigateToIndex(BottomNavigationIndex.more, children: [MoreInternalRoute()]);
  }
}
