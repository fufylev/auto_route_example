import 'package:example/bottom_nav_bar/navigation/navigator.dart';
import 'package:example/bottom_nav_bar/presentation/tab_widget.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final BottomNavigationIndex activeIndex;
  final Function(BottomNavigationIndex index) onTap;
  final List<BottomNavigationIndex> indexes;

  const AppNavigationBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
    required this.indexes,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: width,
            height: 64,
            // decoration: BoxDecoration(
            //   border: Border(top: BorderSide(color: colors.otherDivider, width: 1)),
            //   color: colors.backgroundDefault,
            // ),
            child: Row(children: [
              ...List.generate(
                indexes.length,
                (index) => TabWidget(
                  index: indexes[index],
                  activeIndex: activeIndex,
                  onTap: onTap,
                  tabsCount: indexes.length,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
