import 'package:flutter/material.dart';

import '../../dhis2_service/dhis2_api_service.dart';
import '../../programs/screen/personal_register_screen.dart';
import '../models/program_item.dart';
import '../widgets/home_section_header.dart';
import '../widgets/program_list_item.dart';
import '../widgets/sider_bar_drawer.dart';

class HomeScreen extends StatefulWidget {
  //final String username; // Add username parameter

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Dhis2ApiService _programService;
  List<Map<String, dynamic>> _programs = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _programService = Dhis2ApiService();
    _loadPrograms();
  }

  Future<void> _loadPrograms() async {
    try {
      final programs = await _programService.getPrograms();
      setState(() {
        _programs = programs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SidebarDrawer(username: "Arnold Muleke"),
      body: Column(
        children: [
          const HomeSectionHeader(),
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_errorMessage != null)
            Expanded(
              child: Center(
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _programs.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  final program = _programs[index];
                  return ProgramListItem(
                    item: ProgramItem(
                      icon: _getProgramIcon(program['programType']),
                      title: program['name'] ?? program['id'],
                      subtitle: program['programType'] ?? 'Program',
                      date: 'Last updated',
                      iconColor: _getProgramColor(index),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonRegisterScreen(
                            programId: program['id'],
                            programName: program['name'] ?? program['id'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  IconData _getProgramIcon(String? programType) {
    switch (programType?.toLowerCase()) {
      case 'with_registration':
        return Icons.person;
      case 'without_registration':
        return Icons.assignment;
      case 'community':
        return Icons.groups;
      case 'household':
        return Icons.home;
      default:
        return Icons.list_alt;
    }
  }

  Color _getProgramColor(int index) {
    final colors = [
      Colors.brown,
      Colors.purple,
      Colors.green,
      Colors.redAccent,
      Colors.blue,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }
}