import 'package:get_it/get_it.dart';

T getIt<T extends Object>({
  String? instanceName,
  dynamic param1,
  dynamic param2,
}) =>
    GetIt.instance.get(instanceName: instanceName, param1: param1, param2: param2);

abstract class BaseDIModule {
  void updateInjections(GetIt instance);
}

abstract class AsyncDIModule {
  Future updateInjections(GetIt instance);
}

extension GetItExtension on GetIt {
  void installModule(BaseDIModule module) {
    module.updateInjections(this);
  }

  void installModuleAsync(AsyncDIModule module) async {
    await module.updateInjections(this);
  }
}
