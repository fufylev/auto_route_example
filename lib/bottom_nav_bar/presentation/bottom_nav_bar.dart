// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:home/navigation/navigation_module.gr.dart';
// import 'package:more/navigation/navigation_module.gr.dart';
//
// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AutoTabsScaffold(
//       routes: const [
//         HomeRoute(),
//         MoreRoute(),
//       ],
//       bottomNavigationBuilder: (_, tabsRouter) {
//         return BottomNavigationBar(
//           currentIndex: tabsRouter.activeIndex,
//           onTap: tabsRouter.setActiveIndex,
//           items: const [
//             BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
//             BottomNavigationBarItem(label: 'More', icon: Icon(Icons.more)),
//           ],
//         );
//       },
//     );
//   }
// }
