import 'package:common/di/get_it_extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:home/navigation/navigator.dart';

class HomeDiModule extends BaseDIModule {
  @override
  void updateInjections(GetIt instance) {
    instance.registerFactory<HomeInternalNavigator>(() => HomeInternalNavigatorImpl(router: instance.get()));

    instance.registerFactory<HomeNavigator>(
      () => HomeNavigatorImpl(
        externalNavigator: instance.get<HomeExternalNavigator>(),
        internalNavigator: instance.get<HomeInternalNavigator>(),
      ),
    );
  }
}
