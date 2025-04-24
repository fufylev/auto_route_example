typedef MessageListener = void Function(MessageListenerType type, {String? heading});

abstract class ErrorHandler {
  void proceed(Exception error, [MessageListener? listener]);
}

class ErrorMessage {
  /// Сообщение об ошибке, обрабатываемое внутри Блока с помощью [ErrorHandler]
  const ErrorMessage({
    required this.message,
    this.eventId,
  });

  /// Текстовое сообщение, которое раньше передавалось напрямую в [MessageListener]
  final String message;
  final String? eventId;
}

enum MessageListenerType {
  connectionException,
  timeoutException,
  serverConnectionException,
  unknownException,
  unAuthorizedException,
  serverErrorException,
  cancelationException,
  serviceCodeException,
  requestEntityTooLargeException,
  userAlreadyExistsException,
  compromisedCodeException,
  badCredentialsException,
  validationRegexException,
  verificationCodeNotCorrectException,
  verificationCodeExpiredException,
  badTokenException,
  expiredTokenException,
  refreshTokenExpiredException,
  placeNotFoundException,
  notClassifiedException,
  userHasBlockedYouException,
  userIsDeletedException,
}
