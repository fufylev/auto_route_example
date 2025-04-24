import 'package:common/exception/common_exceptions.dart';
import 'package:common/exception/error_handler.dart';
import 'package:common/exception/sub_code_exceptions.dart';

class DefaultErrorHandler extends ErrorHandler {
  final _handlers = <Type, Function>{};

  /// В теле конструктора добавляем обработчики для каждого типа ошибки
  DefaultErrorHandler() {
    addBasicHandlers();
  }

  /// Добавляет/обновляет обработчик ошибки определенного типа в [_handlers].
  void addHandler<T extends Exception>(void Function(T, [MessageListener?]) handler) {
    _handlers[T] = handler;
  }

  /// Добавляет обработчики для всех базовых типов ошибок
  void addBasicHandlers() {
    addHandler(onConnectionException);
    addHandler(onServerConnectionException);
    addHandler(onServerErrorException);
    addHandler(onTimeoutException);
    addHandler(onUnAuthorizedException);
    addHandler(onUnknownException);
    addHandler(onCancelationException);
    addHandler(onServiceCodeException);
    addHandler(onRequestEntityTooLargeException);
    addHandler(onUserAlreadyExistsException);
    addHandler(onCompromisedCodeException);
    addHandler(onBadCredentialsException);
    addHandler(onValidationRegexException);
    addHandler(onVerificationCodeNotCorrectException);
    addHandler(onVerificationCodeExpiredException);
    addHandler(onBadTokenException);
    addHandler(onTokenExpiredException);
    addHandler(onPlaceNotFoundException);
    addHandler(onNotClassifiedException);
    addHandler(onRefreshTokenExpiredException);
    addHandler(onUserHasBlockedYouException);
    addHandler(onUserIsDeletedException);
  }

  /// Удаляет обработчик для указанного типа ошибки
  void removeHandler(Type type) {
    _handlers.remove(type);
  }

  /// Метод для обработки ошибок. Ищет тип ошибки в [_handlers], после чего
  /// вызывает соответствующий обработчик. Если нужного обработчика нет, вызывается [onOtherException].
  @override
  void proceed(Exception error, [MessageListener? listener]) {
    final type = error.runtimeType;
    final handler = _handlers[type] ?? onOtherException;
    handler(error, listener);
  }

  void onRefreshTokenExpiredException(RefreshTokenExpiredException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.refreshTokenExpiredException);
  }

  void onUserAlreadyExistsException(UserAlreadyExistsException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.userAlreadyExistsException);
  }

  void onCompromisedCodeException(CompromisedCodeException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.compromisedCodeException);
  }

  void onBadCredentialsException(BadCredentialsException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.badCredentialsException);
  }

  void onValidationRegexException(ValidationRegexException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.validationRegexException);
  }

  void onVerificationCodeNotCorrectException(VerificationCodeNotCorrectException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.verificationCodeNotCorrectException);
  }

  void onVerificationCodeExpiredException(VerificationCodeExpiredException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.verificationCodeExpiredException);
  }

  void onBadTokenException(BadTokenException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.badTokenException);
  }

  void onTokenExpiredException(TokenExpiredException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.expiredTokenException);
  }

  void onPlaceNotFoundException(PlaceNotFoundException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.placeNotFoundException);
  }

  void onNotClassifiedException(NotClassifiedException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.notClassifiedException);
  }

  void onConnectionException(ConnectionException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.connectionException);
  }

  void onServerErrorException(ServerErrorException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.serverErrorException);
  }

  void onRequestEntityTooLargeException(RequestEntityTooLargeException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.requestEntityTooLargeException);
  }

  void onServiceCodeException(ServiceCodeException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.serviceCodeException);
  }

  void onCancelationException(CancelationException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.cancelationException);
  }

  void onServerConnectionException(ServerConnectionException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.serverConnectionException);
  }

  void onTimeoutException(TimeoutException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.timeoutException);
  }

  void onUserHasBlockedYouException(UserHasBlockedYouException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.userHasBlockedYouException);
  }

  void onUnAuthorizedException(UnAuthorizedException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.unAuthorizedException);
  }

  void onUserIsDeletedException(UserIsDeletedException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.userIsDeletedException);
  }

  void onUnknownException(UnknownException error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.unknownException);
  }

  /// Вызывается, когда тип ошибки не найден в [_handlers]
  void onOtherException(Exception error, [MessageListener? listener]) {
    listener?.call(MessageListenerType.unknownException);
  }
}
