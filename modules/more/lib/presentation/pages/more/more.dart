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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Произойдет навигация на внутренний экран Intenal без накрытия ботом наивгции'),
            FilledButton(
              child: const Text('Go to Internal screen'),
              onPressed: () => context.read<MoreCubit>().navigateToInternalScreen(),
            ),
            SizedBox(height: 20),
            const Text('Произойдет навигация на внешний экран AccountDetails c перекрытием ботом навигации'),
            FilledButton(
              child: const Text('Go to Account Details screen'),
              onPressed: () => context.read<MoreCubit>().navigateToAccountDetailsScreen(),
            ),
            SizedBox(height: 20),
            const Text('Произойдет прыжок на таб Home'),
            FilledButton(
              child: const Text('Jump to Home tab'),
              onPressed: () => context.read<MoreCubit>().jumpToHomeScreen(),
            ),
            SizedBox(height: 20),
            const Text(
                'Произойдет прыжок на таб Home c открытием внутреннего экрана Intenal без накрытия ботом наивгции'),
            FilledButton(
              child: const Text('Jump to Home tab => Internal screen'),
              onPressed: () => context.read<MoreCubit>().jumpToHomeScreenAndInternalScreen(),
            ),
            SizedBox(height: 20),
            const Text(
                'Произойдет прыжок на таб Home c открытием внешнего экрана AccountDetails c перекрытием ботом навигации'),
            FilledButton(
              child: const Text('Jump to Home tab => Account details screen'),
              onPressed: () => context.read<MoreCubit>().jumpToHomeScreenAndAccountDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
