import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more/presentation/pages/more/more_cubit.dart';

/// Этот класс нужен чтобы работала вложенная навигация для MoreScreen
@RoutePage()
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}

@RoutePage()
class MoreMainPage extends StatelessWidget {
  const MoreMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More Screen'),
        leading: AutoLeadingButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: const Text('Go to internal screen'),
            onPressed: () => context.read<MoreCubit>().navigateToInternalScreen(),
          ),
          TextButton(
            child: const Text('Go to Account Details screen'),
            onPressed: () => context.read<MoreCubit>().navigateToAccountDetailsScreen(),
          ),
          TextButton(
            child: const Text('Jump to Home screen'),
            onPressed: () => context.read<MoreCubit>().jumpToHomeScreen(),
          ),
          TextButton(
            child: const Text('Jump to Home screen with internal screen'),
            onPressed: () => context.read<MoreCubit>().jumpToHomeScreenAndInternalScreen(),
          ),
          TextButton(
            child: const Text('Jump to Home screen with Account details screen'),
            onPressed: () {
              context.read<MoreCubit>().jumpToHomeScreenAndAccountDetails();
            },
          ),
        ],
      ),
    );
  }
}
