import 'package:flutter/material.dart';

import 'fiter_item.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.menu, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Home', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.sync, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.filter_list, color: Colors.white),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const FilterItem(
              icon: Icons.calendar_today,
              title: "DATE",
              subtitle: "No filters applied"),
          const FilterItem(
              icon: Icons.apartment,
              title: "ORG. UNIT",
              subtitle: "No filters applied"),
          const FilterItem(
              icon: Icons.sync, title: "SYNC", subtitle: "No filters applied"),
        ],
      ),
    );
  }
}
