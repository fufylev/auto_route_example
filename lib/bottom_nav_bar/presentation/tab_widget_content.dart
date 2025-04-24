import 'package:flutter/material.dart';

class TabWidgetContent extends StatelessWidget {
  final String tabName;
  final IconData iconPath;
  final bool isActive;
  final double width;
  final double height;

  const TabWidgetContent({
    super.key,
    required this.tabName,
    required this.iconPath,
    required this.isActive,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.red : Colors.black;

    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconPath, color: color),
          Text(
            tabName,
            style: TextStyle(fontSize: 12).copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
