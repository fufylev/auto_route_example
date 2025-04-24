import 'package:common/resources/text_resources.dart';

class ExceptionWithMessage implements Exception {
  final String? message;

  ExceptionWithMessage(this.message);

  @override
  String toString() {
    return message ?? TextResources.defaultError;
  }
}
