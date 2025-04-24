import 'package:common/exception/error_handler.dart';

abstract class BlocNews {}

class ErrorBlocNews extends BlocNews {
  final MessageListenerType type;

  ErrorBlocNews({
    required this.type,
  });

  @override
  String toString() {
    return 'ErrorBlocNews('
        'type: $type, '
        ')';
  }
}

class SuccessBlocNews extends BlocNews {
  final String message;
  final String heading;

  SuccessBlocNews({
    required this.message,
    required this.heading,
  });

  @override
  String toString() {
    return 'ErrorBlocNews('
        'message: $message, '
        'heading: $heading, '
        ')';
  }
}
