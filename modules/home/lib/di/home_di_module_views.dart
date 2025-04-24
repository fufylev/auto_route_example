import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/presentation/pages/home/home.dart';
import 'package:home/presentation/pages/home/home_cubit.dart';

@RoutePage()
class HomeMainView extends StatelessWidget {
  const HomeMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(getIt()),
      child: const HomeMainPage(),
    );
  }
}
