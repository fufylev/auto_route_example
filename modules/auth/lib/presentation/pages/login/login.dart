import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        leading: const AutoLeadingButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: const Text('Go to pin code screen'),
            onPressed: () {
              // context.router.push(route)
              context.read<LoginCubit>().navigateToPinCode();
            },
          ),
          // TextButton(
          //   child: const Text('/main'),
          //   onPressed: () {
          //     context.router.replacePath('/main');
          //   },
          // ),
          // TextButton(
          //   child: const Text('/main_nested'),
          //   onPressed: () {
          //     context.router.replacePath('/main_nested');
          //   },
          // ),
          // TextButton(
          //   child: const Text('/main/more => internal'),
          //   onPressed: () {
          //     context.router.replacePath('/main_nested/more/more_main/internal');
          //     // context.router.pushPath('/more/internal');
          //     // context.router.pushPath('/external');
          //     context.router.replaceAll([
          //       MainRoute(children: [HomeRoute(), MoreRoute(), InternalRoute()])
          //     ]);
          //   },
          // ),
          // TextButton(
          //   child: const Text('/main/more/internal'),
          //   onPressed: () {
          //     context.router.replacePath('/main_nested/more/internal');
          //   },
          // ),
        ],
      ),
    );
  }
}
