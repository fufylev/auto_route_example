import 'package:auto_route/auto_route.dart';

import 'navigation_module.gr.dart';

class AccountDetailsRouter {
  static List<AutoRoute> routers = [
    AutoRoute(
      path: '/account_details',
      page: AccountDetailsMainRoute.page,
    ),
  ];
}

abstract class AccountDetailsExternalNavigator {}

abstract class AccountDetailsInternalNavigator {}

class AccountDetailsInternalNavigatorImpl implements AccountDetailsInternalNavigator {
  // Иcпользуем [StackRouter] из самого пакета auto_route, чтобы не завязываться на родительский [AppRouter]
  // StackRouter нужно будет пробросить в [GetIt] параллельно с [AppRouter]
  final StackRouter router;

  AccountDetailsInternalNavigatorImpl({required this.router});
}

abstract class AccountDetailsNavigator {}

class AccountDetailsNavigatorImpl implements AccountDetailsNavigator {
  final AccountDetailsExternalNavigator externalNavigator;
  final AccountDetailsInternalNavigator internalNavigator;

  AccountDetailsNavigatorImpl(this.internalNavigator, this.externalNavigator);
}
