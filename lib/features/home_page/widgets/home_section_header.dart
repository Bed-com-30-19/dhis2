import 'package:flutter/material.dart';

import 'fiter_item.dart';

class HomeSectionHeader extends StatefulWidget {
  const HomeSectionHeader({super.key});

  @override
  State<HomeSectionHeader> createState() => _HomeSectionHeaderState();
}

class _HomeSectionHeaderState extends State<HomeSectionHeader> {
  bool isExpanded = false;

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
            children: [
              Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.sync, color: Colors.white),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          if (isExpanded) ...[
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
                icon: Icons.sync,
                title: "SYNC",
                subtitle: "No filters applied"),
          ],
        ],
      ),
    );
  }
}