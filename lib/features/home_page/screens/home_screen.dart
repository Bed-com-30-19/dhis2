import 'package:flutter/material.dart';
import '../models/program_item.dart';
import '../widgets/home_section_header.dart';
import '../widgets/program_list_item.dart';

class HomeScreen extends StatelessWidget {
  final List<ProgramItem> programList = [
    ProgramItem(
      icon: Icons.groups,
      title: "1) Community Register",
      subtitle: "1 Community",
      date: "13/5/2025",
      iconColor: Colors.brown,
    ),
    ProgramItem(
      icon: Icons.home,
      title: "2) Household Register",
      subtitle: "1 Household",
      date: "21/3/2025",
      iconColor: Colors.purple,
    ),
    ProgramItem(
      icon: Icons.person,
      title: "3) Person Register",
      subtitle: "2 Person",
      date: "13/5/2025",
      iconColor: Colors.green,
    ),
    ProgramItem(
      icon: Icons.handshake,
      title: "4-0) IMCI - Integrated Community Case Management",
      subtitle: "1 Person",
      date: "21/3/2025",
      iconColor: Colors.redAccent,
    ),
    ProgramItem(
      icon: Icons.table_chart,
      title: "4-1) IMCI - Form 1A Supplies Management Table",
      subtitle: "0 Data sets",
      date: "21/3/2025",
      iconColor: Colors.redAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HomeSectionHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: programList.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) =>
                  ProgramListItem(item: programList[index]),
            ),
          ),
        ],
      ),
    );
  }
}
