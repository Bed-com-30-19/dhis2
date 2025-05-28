import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/program_provider.dart';
import '../widgets/program_header.dart';
import '../widgets/person_details_card.dart';
import '../widgets/program_stage_list.dart';
import '../widgets/bottom_nav_bar.dart';

class ProgramScreen extends StatefulWidget {
  final String personId;
  const ProgramScreen({super.key, required this.personId});

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProgramProvider>(context, listen: false);
    provider.loadPersonDetails(widget.personId);
    provider.loadStages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProgramHeader(),
      body: Column(
        children: const [
          PersonDetailsCard(),
          Expanded(child: ProgramStageList()),
        ],
      ),
      bottomNavigationBar: ProgramBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
