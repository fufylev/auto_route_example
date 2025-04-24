/// Политика кеширования данных счетов и карт
/// [cacheOnly] - данные берутся только из кеша (БД)
///
/// [networkOnly] - данные берутся только из АПИ - запрос на бекенд
///
/// [cacheWhenNetworkFailed] - данные берутся из АПИ и если приходит ошибка,
/// то возвращаем из кеша (БД) сохраненные данные
enum CachePolicy {
  networkOnly,
  cacheOnly,
  cacheWhenNetworkFailed,
}

/// Orchestrator, который отвечает за выбор способа получения данных, их сохранения в БД и возврата данных потребителю
///
/// [getData] - метод получение данных в зависимости от выбранной политики
abstract class CachePolicyOrchestrator {
  Future<T> getData<T>({
    required CachePolicy cachePolicy,
    required Future<T> Function() getFromLocal,
    required Future<T> Function() getFromRemote,
    required Future<void> Function(T data) saveData,
  });
}

/// Имплементация [CachePolicyOrchestrator]
class CachePolicyOrchestratorImpl implements CachePolicyOrchestrator {
  @override
  Future<T> getData<T>({
    required CachePolicy cachePolicy,
    required Future<T> Function() getFromLocal,
    required Future<T> Function() getFromRemote,
    required Future<void> Function(T data) saveData,
  }) async {
    if (cachePolicy == CachePolicy.cacheOnly) {
      /// Берём данные только из БД
      return await getFromLocal();
    } else if (cachePolicy == CachePolicy.networkOnly) {
      /// Берем данные только  из АПИ
      return await _getFromRemoteAndSaveToLocal(getFromLocal, getFromRemote, saveData);
    } else {
      /// срабатает условие [cachePolicy == CachePolicy.cacheWhenNetworkFailed]
      try {
        // Пытаемся получить данные с бэка, записать в кэш, а потом вернуть оттуда
        return await _getFromRemoteAndSaveToLocal(getFromLocal, getFromRemote, saveData);
      } catch (e) {
        try {
          // Если при получении данных с бэка возникла ошибка, пробуем взять данные из кэша
          return await getFromLocal();
        } catch (_) {
          // Если взять данные из кэша не удалось, пробрасываем ошибку с бэка
          throw e;
        }
      }
    }
  }

  /// метод получения данных из АПИ, сохранения в БД и возврата данных  из БД после сохранения
  Future<T> _getFromRemoteAndSaveToLocal<T>(
    Future<T> Function() getFromLocal,
    Future<T> Function() getFromRemote,
    Future<void> Function(T data) saveData,
  ) async {
    // получаем список из remoteDataSource
    final data = await getFromRemote();
    // сохраняем список в БД
    await saveData(data);
    // получаем из БД список и возвращаем его из метода
    return await getFromLocal();
  }
}
