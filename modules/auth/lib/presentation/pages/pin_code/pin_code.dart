import 'package:auth/presentation/pages/pin_code/pin_code_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeView extends StatelessWidget {
  const PinCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pin Code Screen'),
        leading: const AutoLeadingButton(),
      ),
      body: Column(
        children: [
          TextButton(
            child: const Text('Go to main screen'),
            onPressed: () {
              context.read<PinCodeCubit>().navigateToMainScreen();
            },
          ),
        ],
      ),
    );
  }
}
