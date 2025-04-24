/// Ошибка соединения (например, остуствие интернета)
class ConnectionException implements Exception {
  const ConnectionException();
}

/// Ошибка соединения (проблема с сервером)
class ServerConnectionException implements Exception {
  const ServerConnectionException();
}

/// Ошибка при истечении времени ожидания
class TimeoutException implements Exception {
  const TimeoutException();
}

/// Ошибка при завершении срока действия токена сессии
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();
}

class RequestEntityTooLargeException implements Exception {
  const RequestEntityTooLargeException();
}

/// Ошибка при ошибке сервера
class ServerErrorException implements Exception {
  const ServerErrorException();
}

/// Неизвестная ошибка, содержащая оригинальный объект исключения
class UnknownException implements Exception {
  final Object? originalException;

  const UnknownException({this.originalException});
}

/// Ошибка когда статус-код = 200, если клиент пришел с повторным запросом слишком быстро
class TooManyRequestsException implements Exception {
  final String? message;

  const TooManyRequestsException({required this.message});
}

/// Ошибка прерывания запроса
class CancelationException implements Exception {
  const CancelationException();
}

/// Ошибка со статус-кодом и сообщением от бэка (4XX)
class ServiceCodeException implements Exception {
  const ServiceCodeException();
}

/// Ошибка когда в процессе пуллинга был запущен новый пуллинг с тем же id
class InterruptedPullingException implements Exception {
  const InterruptedPullingException();
}
