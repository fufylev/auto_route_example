import 'package:common/common.dart';
import 'package:example/router/router.dart';
import 'package:flutter/material.dart';

import 'di/init_di.dart';
//ignore_for_file: public_member_api_docs

void main() async {
  await initDI();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AppRouter router = getIt();

    return MaterialApp.router(
      routerConfig: router.config(),
      theme: ThemeData.light(),
      builder: (_, router) {
        return router ?? SizedBox.shrink();
      },
    );
  }
}
