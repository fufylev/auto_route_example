import 'dart:async';
import 'dart:math';

import 'package:common/exception/common_exceptions.dart';

/// Интерфейс для механизма пуллинга запросов
abstract class RequestPullOrchestrator {
  /// Запускает пуллинг запросов [code] и возвращает либо результат, либо ошибку
  Future<T> startPulling<T>(
    /// Запрос, который будет повторяться с определенной переодичностью
    Future<T> Function() code, {
    /// Уникальный идентификатор пуллинга. Нужен для того, чтобы в случае повторного запуска
    /// еще не завершенного пуллинга, завершить текущий и начать новый
    String? key,

    /// Стратегия, определяющая интервалы между запросами
    required RequestPullStrategy strategy,

    /// Условие, при котором нужно закончить пуллинг и вернуть данные, полученные в результате очередного запроса
    required bool Function(T) successCompletePredicate,

    /// Условие, при котором нужно закончить пуллинг и вернуть ошибку, полученную в результате очередного запроса
    bool Function(Object)? errorCompletePredicateOverride,
  });

  /// Условие по умолчанию, при котором нужно закончить пуллинг и вернуть ошибку,
  /// полученную в результате очередного запроса
  bool errorCompletePredicate(Object error);

  /// Остановить пуллинг с указанным [key] и выдать исключение [InterruptedPullingException] либо
  /// [customError]
  void stopPulling(String key, [Object? customError]);

  /// Остановить все пуллинги и выдать для каждого из них исключение [InterruptedPullingException] либо
  /// [customError]
  void stopAll([Object? customError]);
}

class BaseRequestPullOrchestrator extends RequestPullOrchestrator {
  /// Хранит комплитеры для каждого ключа пуллинга
  final _keyMap = <String, Completer>{};

  @override
  Future<T> startPulling<T>(
    Future<T> Function() code, {
    String? key,
    required RequestPullStrategy strategy,
    required bool Function(T) successCompletePredicate,
    bool Function(Object)? errorCompletePredicateOverride,
  }) {
    // Ключ текущего пуллинга. Либо указанный при вызове метода, либо рандомный
    final currentKey = key ?? _randomKey();

    // Если уже запущен пуллинг с таким же ключом, завершаем его
    final previousCompleter = _keyMap[currentKey];
    if (previousCompleter != null) {
      previousCompleter.completeError(const InterruptedPullingException());
    }

    // Создаем новый комплитер и сохраняем в мапу
    final completer = Completer<T>();
    _keyMap[currentKey] = completer;

    Future<T>(() async {
      // Повторяем цикл [ожидание -> запрос], пока запрос не вернет результат, подходящий по условию
      // successCompletePredicate, либо ошибку, подходящую под условие errorPredicate
      while (!completer.isCompleted) {
        final delay = strategy.getNextDelay();
        await Future.delayed(delay);
        try {
          final result = await code();
          // Условие прекращения пуллинга и возвращения результата в блок [then]
          if (successCompletePredicate(result)) {
            return result;
          }
        } catch (e) {
          // Условие прекращения пуллинга и возвращения ошибки в блок [catchError]
          final errorPredicate = errorCompletePredicateOverride ?? errorCompletePredicate;
          if (errorPredicate(e)) {
            rethrow;
          }
        }
      }
      throw const TimeoutException();
    }).then((value) {
      // Возвращаем через комплитер результат, успешно прошедший проверку на соответствие предикату
      if (!completer.isCompleted) {
        _keyMap.remove(currentKey);
        completer.complete(value);
      }
    }).catchError((e) {
      // Возвращаем через комплитер ошибку, успешно прошедшую проверку на соответствие предикату
      if (!completer.isCompleted) {
        _keyMap.remove(currentKey);
        completer.completeError(e);
      }
    }).timeout(strategy.timeoutDuration, onTimeout: () {
      // Возвращаем через комплитер ошибку TimeoutException
      if (!completer.isCompleted) {
        _keyMap.remove(currentKey);
        completer.completeError(const TimeoutException());
      }
    });

    return completer.future;
  }

  @override
  bool errorCompletePredicate(Object error) => error is ServerErrorException;

  @override
  void stopPulling(String key, [Object? customError]) {
    final completer = _keyMap[key];
    if (completer != null && !completer.isCompleted) {
      _keyMap.remove(key);
      completer.completeError(customError ?? const InterruptedPullingException());
    }
  }

  @override
  void stopAll([Object? customError]) {
    _keyMap.forEach((_, completer) {
      completer.completeError(customError ?? const InterruptedPullingException());
    });
    _keyMap.clear();
  }

  /// Генерирует рандомный ключ для пуллинга
  String _randomKey() {
    return '${DateTime.now().toIso8601String()}-${Random().nextDouble()}';
  }
}

/// Интерфейс стратегии пуллинга
abstract class RequestPullStrategy {
  RequestPullStrategy({required this.timeoutDuration});

  /// Через какое время нужно прекратить пуллинг
  Duration timeoutDuration;

  /// Метод для получения задержки перед очередным запросом. Задержка происходит даже перед самым первым запросом,
  /// это стоит учитывать при написании реализации стратегии
  Duration getNextDelay();
}

class BaseRequestPullStrategy extends RequestPullStrategy {
  /// Стратегия A, B, B, B, B, B, ... где A = 0, B = 1 по умолчанию
  BaseRequestPullStrategy({
    this.firstDelay = Duration.zero,
    this.otherDelays = const Duration(seconds: 1),
    required super.timeoutDuration,
  });

  final Duration firstDelay;
  final Duration otherDelays;

  int _currentStep = 0;

  @override
  Duration getNextDelay() {
    final result = _currentStep == 0 ? firstDelay : otherDelays;
    _currentStep++;
    return result;
  }
}

class FibonacciRequestPullStrategy extends RequestPullStrategy {
  /// Стратегия 0, 1, 1, 2, 3, 5, 8, ... (числа Фибоначчи)
  FibonacciRequestPullStrategy({
    required super.timeoutDuration,
  });

  int _next = 0;
  int _afterNext = 1;

  @override
  Duration getNextDelay() {
    final result = _next;
    _next = _afterNext;
    _afterNext += result;
    return Duration(seconds: result);
  }
}
