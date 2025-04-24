import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MoreInternalScreen extends StatelessWidget {
  const MoreInternalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internal More screen'),
        leading: const AutoLeadingButton(),
      ),
    );
  }
}
