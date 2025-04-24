import 'package:auth/presentation/pages/login/login.dart';
import 'package:auth/presentation/pages/login/login_cubit.dart';
import 'package:auth/presentation/pages/pin_code/pin_code.dart';
import 'package:auth/presentation/pages/pin_code/pin_code_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(getIt()),
      child: const LoginView(),
    );
  }
}

@RoutePage()
class PinCodeScreen extends StatelessWidget {
  const PinCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinCodeCubit>(
      create: (context) => PinCodeCubit(getIt()),
      child: const PinCodeView(),
    );
  }
}
