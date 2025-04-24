import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BaseNotifierMixin {}

abstract class BaseNotifier with BlocNewsMixin, UseCaseProcessorMixin {
  BaseNotifier({
    ErrorHandler? errorHandler,
  }) {
    initProcessor(errorHandler);
  }
}

abstract class BaseBloc<EventT, StateT> extends Bloc<EventT, StateT> with BlocNewsMixin, UseCaseProcessorMixin {
  BaseBloc(
    super.initialState, {
    ErrorHandler? errorHandler,
  }) {
    initProcessor(errorHandler);
  }

  void emitIfNotClosed(Emitter<StateT> emitter, StateT state) {
    if (!isClosed) {
      emitter(state);
    }
  }

  void addIfNotClosed(EventT event) {
    if (!isClosed) {
      super.add(event);
    }
  }

  @override
  void addNews(BlocNews news) {
    if (!isClosed) {
      super.addNews(news);
    }
  }

  Future<void> pushClose() async => close();

  @override
  @mustCallSuper
  Future<void> close() async {
    await closeProcessor();

    return super.close();
  }
}
