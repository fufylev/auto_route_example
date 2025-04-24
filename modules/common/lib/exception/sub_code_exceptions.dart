sealed class CustomCodeException implements Exception {
  final int subCode;
  const CustomCodeException(this.subCode);
}

class UserAlreadyExistsException extends CustomCodeException {
  const UserAlreadyExistsException(super.subCode);
}

/// Код уже использовался
class CompromisedCodeException extends CustomCodeException {
  const CompromisedCodeException(super.subCode);
}

class BadCredentialsException extends CustomCodeException {
  const BadCredentialsException(super.subCode);
}

class ValidationRegexException extends CustomCodeException {
  const ValidationRegexException(super.subCode);
}

class VerificationCodeNotCorrectException extends CustomCodeException {
  const VerificationCodeNotCorrectException(super.subCode);
}

class VerificationCodeExpiredException extends CustomCodeException {
  const VerificationCodeExpiredException(super.subCode);
}

class BadTokenException extends CustomCodeException {
  const BadTokenException(super.subCode);
}

class TokenExpiredException extends CustomCodeException {
  const TokenExpiredException(super.subCode);
}

class RefreshTokenExpiredException extends CustomCodeException {
  const RefreshTokenExpiredException(super.subCode);
}

class PlaceNotFoundException extends CustomCodeException {
  const PlaceNotFoundException(super.subCode);
}

class UserHasBlockedYouException extends CustomCodeException {
  const UserHasBlockedYouException(super.subCode);
}

class UserIsDeletedException extends CustomCodeException {
  const UserIsDeletedException(super.subCode);
}

/// Код еще не классифицирован на фронте
class NotClassifiedException extends CustomCodeException {
  const NotClassifiedException(super.subCode);
}

CustomCodeException getCustomCodeException(int subCode) {
  return switch (subCode) {
    4000 => const UserAlreadyExistsException(4000),
    4001 => const CompromisedCodeException(4001),
    4002 => const BadCredentialsException(4002),
    4003 => const ValidationRegexException(4003),
    4004 => const VerificationCodeNotCorrectException(4004),
    4005 => const VerificationCodeExpiredException(4005),
    4006 => const BadTokenException(4006),
    4007 => const TokenExpiredException(4007),
    4008 => const PlaceNotFoundException(4008),
    4009 => const RefreshTokenExpiredException(4009),
    5000 => const UserHasBlockedYouException(5000),
    5002 => const UserIsDeletedException(5002),
    _ => const NotClassifiedException(0),
  };
}
