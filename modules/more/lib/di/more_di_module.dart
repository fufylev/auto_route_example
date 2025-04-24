import 'package:common/di/get_it_extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:more/navigation/navigator.dart';

class MoreDiModule extends BaseDIModule {
  @override
  void updateInjections(GetIt instance) {
    instance.registerFactory<MoreInternalNavigator>(() => MoreInternalNavigatorImpl(router: instance.get()));

    instance.registerFactory<MoreNavigator>(
      () => MoreNavigatorImpl(
        externalNavigator: instance.get<MoreExternalNavigator>(),
        internalNavigator: instance.get<MoreInternalNavigator>(),
      ),
    );
  }
}
