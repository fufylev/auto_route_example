import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeInternalScreen extends StatelessWidget {
  const HomeInternalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Internal home screen'),
        leading: const AutoLeadingButton(),
      ),
    );
  }
}
