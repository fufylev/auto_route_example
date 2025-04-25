import 'package:auto_route/auto_route.dart';
import 'package:common/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';

/// Этот класс нужен чтобы работала вложенная навигация для Home
@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

/// Стартовый экран для [Home]
class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends StateWithCubit<HomeCubit, HomeMainPage> {
  @override
  void onNewsReceived(BlocNews news) {
    if (news is ShowEventOnListener) {
      const snackBar = SnackBar(content: Text('Мы ушли с экрана Internal'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    super.onNewsReceived(news);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        leading: const AutoLeadingButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: const Text('Go to internal screen'),
            onPressed: () => context.read<HomeCubit>().navigateToInternalScreen(),
          ),
          TextButton(
            child: const Text('Go to Account Details screen'),
            onPressed: () => context.read<HomeCubit>().navigateToAccountDetailsScreen(),
          ),
          TextButton(
            child: const Text('Jump to More screen'),
            onPressed: () => context.read<HomeCubit>().jumpToMoreScreen(),
          ),
          TextButton(
            child: const Text('Jump to More screen with internal screen'),
            onPressed: () => context.read<HomeCubit>().jumpToMoreScreenAndInternalScreen(),
          ),
        ],
      ),
    );
  }
}
