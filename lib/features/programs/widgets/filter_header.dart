import 'package:flutter/material.dart';

class FilterHeader extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final String selectedProgram;
  final List<String> programs;
  final Function(String) onProgramChanged;
  final String? selectedOrgUnit;
  final List<String> orgUnits;
  final Function(String?)? onOrgUnitChanged;
  final Color headerColor;

  const FilterHeader({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.selectedProgram,
    required this.programs,
    required this.onProgramChanged,
    required this.headerColor, 
    this.selectedOrgUnit,
    this.orgUnits = const [],
    this.onOrgUnitChanged,
  });

  @override
  State<FilterHeader> createState() => _FilterHeaderState();
}

class _FilterHeaderState extends State<FilterHeader> {
  late String _selectedProgram;
  String? _selectedOrgUnit;

  @override
  void initState() {
    super.initState();
    _selectedProgram = widget.selectedProgram;
    _selectedOrgUnit = widget.selectedOrgUnit;
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

  void _showOrgUnitDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: widget.orgUnits.map((orgUnit) {
            return ListTile(
              title: Text(orgUnit),
              onTap: () {
                setState(() => _selectedOrgUnit = orgUnit);
                widget.onOrgUnitChanged?.call(orgUnit);
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
          color: widget.headerColor, 
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), 
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showProgramDropdown(context),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedProgram,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          overflow: TextOverflow.ellipsis, 
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
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
            color: widget.headerColor, 
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterItem(Icons.calendar_today, "EVENT DATE"),
                _buildFilterItem(Icons.calendar_today, "DATE OF PERSON REGISTRATION"),
                _buildOrgUnitFilter(),
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

  Widget _buildOrgUnitFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // ✅ More breathing room
      child: Row(
        children: [
          const Icon(Icons.apartment, color: Colors.white70),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _showOrgUnitDropdown(context),
            child: Row(
              children: [
                Text(
                  _selectedOrgUnit ?? "ORG. UNIT",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
