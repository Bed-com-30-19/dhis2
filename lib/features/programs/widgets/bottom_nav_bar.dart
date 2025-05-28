import 'package:flutter/material.dart';

class ProgramBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const ProgramBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Details"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Analytics"),
        BottomNavigationBarItem(icon: Icon(Icons.note), label: "Notes"),
      ],
    );
  }
}
