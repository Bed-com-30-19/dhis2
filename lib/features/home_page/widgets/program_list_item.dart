import 'package:flutter/material.dart';
import '../models/program_item.dart';

class ProgramListItem extends StatelessWidget {
  final ProgramItem item;

  const ProgramListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.iconColor.withOpacity(0.2),
          child: Icon(item.icon, color: item.iconColor),
        ),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.subtitle),
        trailing: Text(item.date, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}