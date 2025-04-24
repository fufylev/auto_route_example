import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

/// Skips the first [count] events.
///
/// ### Example
///     on<ExampleEvent>(
///       _handleEvent,
///       transformer: skip(10),
///     )
//* Пример визуализации https://rxmarbles.com/#skip
EventTransformer<Event> skip<Event>(int count) {
  return (events, mapper) => events.skip(count).switchMap(mapper);
}

/// The `delay()` transformer is pausing adding events for a particular
/// increment of time (that you specify) before emitting each of the events.
/// This has the effect of shifting the entire sequence of
/// events added to the bloc forward in time by that specified increment.
///
/// [Interactive marble diagram](http://rxmarbles.com/#delay)
///
/// ### Example
///     on<ExampleEvent>(
///       _handleEvent,
///       transformer: delay(const Duration(seconds: 1)),
///     );
//* Пример визуализации https://rxmarbles.com/#delay
EventTransformer<Event> delay<Event>(Duration duration) {
  return (events, mapper) => events.delay(duration).switchMap(mapper);
}

/// Emits an [Event], then ignores subsequent events
/// for a [duration], then repeats this process.
///
/// If [leading] is true, then the first event in each window is emitted.
/// If [trailing] is true, then the last event is emitted instead.
///
/// ### Example
///     on<ExampleEvent>(
///       _handler,
///       transformer: throttle(const Duration(seconds: 5))
///     );
//* Пример визуализации https://rxmarbles.com/#throttleTime
EventTransformer<Event> throttleTransformer<Event>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).switchMap(mapper);
}

/// Event transformer that will only emit items from the source
/// sequence whenever the time span defined by [duration] passes, without the
/// source sequence emitting another item.
///
/// This time span start after the last debounced event was emitted.
///
/// debounce filters out items obtained events that are
/// rapidly followed by another emitted event.
///
/// [Interactive marble diagram](http://rxmarbles.com/#debounceTime)
///
/// ### Example
///     on<ExampleEvent>(
///       _handleEvent,
///       transformer: debounce(const Duration(seconds: 1)),
///     );
//* Пример визуализации https://rxmarbles.com/#debounceTime
EventTransformer<Event> debounceTransformer<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

//! ДОКУМЕНТАЦИЯ по данным двум методам => Throttle && Debounce
///
/// В программировании, особенно при работе с событиями (например, скроллом или вводом текста),
/// throttle и debounce — это два разных подхода к ограничению частоты вызовов функций.
///
/// Когда что использовать?
/// Throttle — когда важно гарантировать периодический вызов (например, при скролле).
///
/// Debounce — когда нужно ждать окончания активности (например, поиск после остановки ввода).
///
/// Если у вас есть конкретный сценарий, могу помочь подобрать оптимальный подход! 🚀
///
//* 1. Throttle (троттлинг)
/// Throttle гарантирует, что функция будет вызываться не чаще, чем раз в указанный промежуток времени, даже если событие срабатывает чаще.
///
//* Пример на Dart:
/// Function _throttle(Function func, Duration duration) {
///   Timer? timer;
///   bool isThrottled = false;
///
///   return () {
///     if (!isThrottled) {
///       isThrottled = true;
///       timer = Timer(duration, () => isThrottled = false);
///       func();
///     }
///   };
/// }
///
/// void main() {
///   final throttledPrint = _throttle(() => print("Throttled!"), Duration(seconds: 1));
///
///   // Симулируем частые вызовы (например, скролл)
///   for (int i = 0; i < 10; i++) {
///     throttledPrint(); // Вызовется только 1 раз в секунду
///   }
/// }
/// Вывод:
/// Throttled!
/// (и больше ничего, пока не пройдёт 1 секунда)

//* 2. Debounce (дебаунс)
/// Debounce откладывает вызов функции до тех пор, пока не пройдёт указанный промежуток времени без новых событий.
///
//* Пример на Dart:
///Function _debounce(Function func, Duration duration) {
///  Timer? timer;
///
///  return () {
///    timer?.cancel(); // Сбрасываем предыдущий таймер
///    timer = Timer(duration, () => func());
///  };
///}
///
///void main() {
///  final debouncedPrint = _debounce(() => print("Debounced!"), Duration(seconds: 1));
///
///  // Симулируем частые события (например, ввод текста)
///  for (int i = 0; i < 5; i++) {
///    debouncedPrint();
///    await Future.delayed(Duration(milliseconds: 500)); // Новое событие через 0.5 сек
///  }
///
///  // Ждём 1 секунду без событий
///  await Future.delayed(Duration(seconds: 1));
///  debouncedPrint(); // Вызовется только этот
/// }
/// Вывод:
/// Copy
/// Debounced!
/// (только после паузы в 1 секунду)

/*
Ключевые отличия:

Параметр	            Throttle	                    Debounce
--------              ------------------------      ------------------------------
Вызов	                Раз в N времени	              Только после паузы в N времени
Пример	              Игнорирует частые события	    Ждёт окончания событий
Использование	        Скролл, ресайз	              Поиск при вводе текста
*/
