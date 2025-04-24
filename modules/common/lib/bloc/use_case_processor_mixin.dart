import 'dart:async';

import 'package:common/bloc/bloc_news_mixin.dart';
import 'package:common/bloc/news.dart';
import 'package:common/exception/error_handler.dart';
import 'package:common/usecase/usecase.dart';

/// Миксин для выполнения и обработки результатов UseCase
mixin UseCaseProcessorMixin on BlocNewsMixin {
  late final ErrorHandler? errorHandler;

  /// Подписки для всех StreamUseCase, которые выполняются в рамках работы этого Bloc
  final List<StreamSubscription<UseCaseResult>> subscriptions = [];

  void initProcessor(ErrorHandler? errorHandler) {
    newsStream = newsController.stream;
    this.errorHandler = errorHandler;
  }

  /// Обработчик для всех [UseCaseResult]. Если результат выполнения - [UseCaseResult.successful], вызывается [onSuccess].
  /// В противном случае вызывается onError, если он указан. Если onError не указан, вызывается [handleErrorByDefault].
  void _processUseCaseResult<T>(
    UseCaseResult<T> useCaseResult, {
    required void Function(T result) onSuccess,
    void Function(Exception error)? onError,
  }) {
    if (useCaseResult.isSuccessful) {
      onSuccess(useCaseResult.result);
    } else {
      final handler = onError ?? handleUseCaseError;
      handler.call(useCaseResult.exception);
    }
  }

  /// Обработка асинхронного UseCase
  Future<void> processUseCase<T>(
    Future<UseCaseResult<T>> Function() useCase, {
    required void Function(T result) onSuccess,
    void Function(Exception error)? onError,
  }) async {
    final useCaseResult = await useCase();

    _processUseCaseResult(
      useCaseResult,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Обработка синхронного UseCase
  void processSyncUseCase<T>(
    UseCaseResult<T> useCaseResult, {
    required void Function(T result) onSuccess,
    void Function(Exception error)? onError,
  }) {
    _processUseCaseResult(
      useCaseResult,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Обработка StreamUseCase
  StreamSubscription<UseCaseResult<T>> processStreamUseCase<T>(
    Stream<UseCaseResult<T>> Function() useCase, {
    required void Function(T result) onSuccess,
    void Function(Object error)? onError,
  }) {
    final subscription = useCase().listen(
      (useCaseResult) => _processUseCaseResult(
        useCaseResult,
        onSuccess: onSuccess,
        onError: onError,
      ),
    );
    subscriptions.add(subscription);
    return subscription;
  }

  /// Обработчик ошибок для всех useCase. Вызывается, если в результате выполнения [processUseCase] вернулся
  /// [UseCaseResult.failure], и при этом в [processUseCase] не был передан параметр onError.
  /// В своих Блоках и Кубитах можно переопределять при необходимости
  void handleUseCaseError(Exception error) {
    errorHandler?.proceed(error, (MessageListenerType type, {String? heading}) {
      addNews(ErrorBlocNews(type: type));
    });
  }

  Future<void> closeProcessor() async {
    await newsController.close();
    await Future.wait(subscriptions.map((e) => e.cancel()));
  }
}
