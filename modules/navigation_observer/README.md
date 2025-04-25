# Модуль для обработки событий навигации

> Документацию по классам смотреть в коде

## Пример использования
Внутри модуля добавить `navigation_observer` в зависимости
и обсервер
```dart
abstract class MainScreenObserver extends RouteObserver {
  @override
  List<RouteSelector> get selectors => [RouteNameSelector(MainScreenRoute.name, CardDetails.name)];

 @override
 void didPop(Route route, Route? previousRoute) {
   print(route.settings.name);
 }
}
```

> Опционально, если для корректной работы вашего обсервера, вам нужны зависимости на другие роуты,
> можно внутри своего модуля сделать обсервер абстрактным и определить только бизнес логику для его 
> работы, без селекторов
> ```dart
>class MainScreenObserver extends RouteObserver {
>  @override
>  List<RouteSelector> get selectors => [RouteNameSelector(MainScreenRoute.name, CardDetails.name)];
>
>  @override
>  void didPop(Route route, Route? previousRoute) {
>    print(route.settings.name);
>  }
>}
>```
>Далее в `lib/observers` добавить реализацию данного класса с необходимыми селекторами
>```dart
>class MainScreenObserverImpl extends MainScreenObserver {
>  @override
>  List<RouteSelector> get selectors => [RouteNameSelector(MainScreenRoute.name, CardDetails.name)];
>}
>```

Зарегистрировать ваш обсервер внутри `lib/observer_di_module.dart`
```dart
// ...
observer.register(MainScreenObserver());
// ...
```

## Селекторы
Селекторы используются для определения поведения срабатывания вашего обсервера при навигации

Каждый селектор должен реализовывать `RouteSelector` интерфейс

Обсервер вызывается если хотя бы один из селекторов вернул `true`