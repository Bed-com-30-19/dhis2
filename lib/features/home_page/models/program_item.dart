import 'package:flutter/material.dart';

class ProgramItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;
  final Color iconColor;

  ProgramItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.iconColor,
  });
}
