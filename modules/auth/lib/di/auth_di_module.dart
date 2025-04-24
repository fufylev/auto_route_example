import 'package:auth/navigation/navigator.dart';
import 'package:common/di/get_it_extensions.dart';
import 'package:get_it/get_it.dart';

class AuthDiModule extends BaseDIModule {
  @override
  void updateInjections(GetIt instance) {
    instance.registerFactory<AuthInternalNavigator>(() => AuthInternalNavigatorImpl(router: instance.get()));

    instance.registerFactory<AuthNavigator>(
      () => AuthNavigatorImpl(
        externalNavigator: instance.get<AuthExternalNavigator>(),
        internalNavigator: instance.get<AuthInternalNavigator>(),
      ),
    );
  }
}
