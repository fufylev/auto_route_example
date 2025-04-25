import 'package:common/di/get_it_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/close_app_action_cubit.dart';

class CloseAppBottomSheet extends StatelessWidget {
  const CloseAppBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CloseAppActionCubit>(
      create: (_) => CloseAppActionCubit(router: getIt()),
      child: const CloseAppActionsBottomSheet(),
    );
  }
}

/// Подтверждение выхода из приложения
class CloseAppActionsBottomSheet extends StatelessWidget {
  const CloseAppActionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CloseAppActionCubit>();

    return Container(
      padding: const EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FilledButton(
            child: Text('Выйти'),
            onPressed: bloc.exitApp,
          ),
          const SizedBox(width: 20),
          FilledButton(
            child: Text('Отменить'),
            onPressed: bloc.closeView,
          ),
        ],
      ),
    );
  }
}
