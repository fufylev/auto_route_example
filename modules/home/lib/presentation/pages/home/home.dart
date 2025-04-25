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
      const snackBar = SnackBar(content: Text('Мы ушли с экрана Internal'), duration: Duration(seconds: 1));

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Произойдет навигация на внутренний экран Intenal без накрытия ботом наивгции'),
            FilledButton(
              child: const Text('Go to Internal screen'),
              onPressed: () => context.read<HomeCubit>().navigateToInternalScreen(),
            ),
            const SizedBox(height: 20),
            const Text('Произойдет навигация на внешний экран AccountDetails c перекрытием ботом навигации'),
            FilledButton(
              child: const Text('Go to Account Details screen'),
              onPressed: () => context.read<HomeCubit>().navigateToAccountDetailsScreen(),
            ),
            const SizedBox(height: 20),
            const Text('Произойдет прыжок на таб More'),
            FilledButton(
              child: const Text('Jump to More tab'),
              onPressed: () => context.read<HomeCubit>().jumpToMoreScreen(),
            ),
            const SizedBox(height: 20),
            const Text(
                'Произойдет прыжок на таб More c открытием внутреннего экрана Intenal без накрытия ботом наивгции'),
            FilledButton(
              child: const Text('Jump to More tab => Internal screen'),
              onPressed: () => context.read<HomeCubit>().jumpToMoreScreenAndInternalScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
