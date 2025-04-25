import 'package:example/bottom_nav_bar/navigation/navigator.dart';
import 'package:example/bottom_nav_bar/presentation/tab_widget_content.dart';
import 'package:flutter/material.dart';

// todo вынести в uikit
const _barNavigationTabHeight = 64.0;

/// Формирующий виджет таба (bottom navigation)
class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.index,
    required this.onTap,
    required this.activeIndex,
    required this.tabsCount,
  });

  final BottomNavigationIndex index;
  final BottomNavigationIndex activeIndex;
  final Function(BottomNavigationIndex index) onTap;
  final int tabsCount;

  String _getTabName(BottomNavigationIndex currentIndex) {
    return switch (currentIndex) {
      BottomNavigationIndex.home => 'Home', // TODO - локализация
      BottomNavigationIndex.more => 'More', // TODO - локализация
    };
  }

  IconData _getIconPath(BottomNavigationIndex currentIndex) {
    return switch (currentIndex) {
      BottomNavigationIndex.home => Icons.home,
      BottomNavigationIndex.more => Icons.more,
    };
  }

  Widget _getTabWidget({
    required BottomNavigationIndex index,
    required Function(BottomNavigationIndex index) onTap,
    required BottomNavigationIndex activeIndex,
    required int tabsCount,
    required double tabWidth,
  }) {
    final tabName = _getTabName(index);
    final iconPath = _getIconPath(index);
    final isActive = index == activeIndex;

    switch (index) {
      case BottomNavigationIndex.home:
      case BottomNavigationIndex.more:
        return TabWidgetContent(
          tabName: tabName,
          iconPath: iconPath,
          isActive: isActive,
          width: tabWidth,
          height: _barNavigationTabHeight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabWidth = MediaQuery.sizeOf(context).width / tabsCount;

    return InkWell(
      onTap: () => onTap(index),
      child: _getTabWidget(
        index: index,
        tabWidth: tabWidth,
        onTap: onTap,
        activeIndex: activeIndex,
        tabsCount: tabsCount,
      ),
    );
  }
}
