import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FilterItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
