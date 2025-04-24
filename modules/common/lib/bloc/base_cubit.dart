import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<StateT> extends Cubit<StateT> with BlocNewsMixin, UseCaseProcessorMixin {
  BaseCubit(
    super.initialState, {
    ErrorHandler? errorHandler,
  }) {
    initProcessor(errorHandler);
  }

  void emitIfNotClosed(StateT state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  @override
  void addNews(BlocNews news) {
    if (!isClosed) {
      super.addNews(news);
    }
  }

  @override
  @mustCallSuper
  Future<void> close() async {
    await closeProcessor();

    return super.close();
  }
}
