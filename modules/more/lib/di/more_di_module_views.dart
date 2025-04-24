import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more/presentation/pages/more/more.dart';
import 'package:more/presentation/pages/more/more_cubit.dart';

@RoutePage()
class MoreMainView extends StatelessWidget {
  const MoreMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoreCubit>(
      create: (context) => MoreCubit(getIt()),
      child: const MoreMainPage(),
    );
  }
}
