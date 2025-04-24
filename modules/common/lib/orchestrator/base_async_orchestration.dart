import 'dart:async';

/// Выбор типа поведения оркестратора
/// [awaitExecute] - с проверкой на наличие выполнения процесса
/// [proceedAll] - выполнение процесса без задержки
enum AsyncOrchestratorBehavior { awaitExecute, proceedAll }

/// Оркестратор, который может либо предотвратить повторное выполнение процесса либо выполнить его без задержки
abstract class AsyncOrchestrator {
  Future<T> execute<T>(Future<T> Function() code, String key, {behavior = AsyncOrchestratorBehavior.awaitExecute});
}

class BaseAsyncOrchestrator implements AsyncOrchestrator {
  /// Маппер списков комплитеров
  final Map<String, List<Completer>> lockMap = {};

  @override
  Future<T> execute<T>(Future<T> Function() code, String key, {behavior = AsyncOrchestratorBehavior.awaitExecute}) {
    switch (behavior) {
      case AsyncOrchestratorBehavior.awaitExecute:
        return _awaitExecute(code, key);

      case AsyncOrchestratorBehavior.proceedAll:
        return _proceedAll(code, key);

      default:
        return _awaitExecute(code, key);
    }
  }

  /// Метод, в котором идёт проверка наличия в маппере [lockMap] записи с ключом [key] для исключения повторного
  /// ВЫПОЛНЕНИЯ функционала в функции [code].
  Future<T> _awaitExecute<T>(Future<T> Function() code, String key) async {
    final completer = Completer<T>();

    /* Если в маппере [lockMap] есть запись с ключом [key] то добавляем текущий completer в список и возвращаем
    future. Когда завершится выполнение уже запущенной сессии [code] произойдет завершение и текущего комплитера */
    if (lockMap.containsKey(key)) {
      lockMap[key]?.add(completer);
      return completer.future;
    }

    // Добавляем в список текущий комплитер
    lockMap.putIfAbsent(key, () => [completer]);

    // выполняем код
    code().then((value) {
      final completerList = lockMap[key] ?? [];
      for (var i = 0; i < completerList.length; i++) {
        // завершаем все комплитеры в списке по ключу [key]
        completerList[i].complete(value);
      }
      // удаляем запись из маппера
      lockMap.remove(key);
    }).catchError((e) {
      final completerList = lockMap[key] ?? [];
      for (var i = 0; i < completerList.length; i++) {
        // завершаем все комплитеры в списке по ключу [key]
        completerList[i].completeError(e);
      }
      // удаляем запись из маппера
      lockMap.remove(key);
    });

    return completer.future;
  }

  /// Возвращаем выполнение [code]
  Future<T> _proceedAll<T>(Future<T> Function() code, String key) => code();
}
