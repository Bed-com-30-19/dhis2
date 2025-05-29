import 'package:flutter/material.dart';

class FilterHeader extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final String selectedProgram;
  final List<String> programs;
  final Function(String) onProgramChanged;

  const FilterHeader({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.selectedProgram,
    required this.programs,
    required this.onProgramChanged,
  });

  @override
  State<FilterHeader> createState() => _FilterHeaderState();
}

class _FilterHeaderState extends State<FilterHeader> {
  late String _selectedProgram;

  @override
  void initState() {
    super.initState();
    _selectedProgram = widget.selectedProgram;
  }

  void _showProgramDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: widget.programs.map((program) {
            return ListTile(
              title: Text(program),
              onTap: () {
                setState(() => _selectedProgram = program);
                widget.onProgramChanged(program);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top bar always visible
        Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _showProgramDropdown(context),
                child: Row(
                  children: [
                    Text(
                      _selectedProgram,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: widget.onToggle,
              ),
            ],
          ),
        ),

        // Filters (expandable section)
        if (widget.isExpanded)
          Container(
            color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterItem(Icons.calendar_today, "EVENT DATE"),
                _buildFilterItem(Icons.calendar_today, "DATE OF PERSON REGISTRATION"),
                _buildFilterItem(Icons.apartment, "ORG. UNIT"),
                _buildFilterItem(Icons.sync, "SYNC"),
                _buildFilterItem(Icons.verified_user, "ENROLLMENT STATUS"),
                _buildFilterItem(Icons.event, "EVENT STATUS"),
                _buildFollowedToggle(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
                    onPressed: widget.onToggle,
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFilterItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildFollowedToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.notifications, color: Colors.white70),
          const SizedBox(width: 10),
          const Text("FOLLOWED UP PERSON", style: TextStyle(color: Colors.white)),
          const Spacer(),
          Switch(value: false, onChanged: (_) {}),
        ],
      ),
    );
  }
}
