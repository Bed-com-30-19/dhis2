import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dhis2_service/dhis2_api_service.dart';
import '../entities/person.dart';
import '../entities/tracked_entity_instance.dart';
import '../provider/personal_register_provider.dart';
import '../widgets/filter_header.dart';
import '../widgets/personal_list_item.dart';

class PersonRegisterScreen extends StatefulWidget {
  final String programId;
  final String programName;
  final Color headerColor;

  const PersonRegisterScreen({
    super.key,
    required this.programId,
    required this.programName,
    required this.headerColor,
  });

  @override
  State<PersonRegisterScreen> createState() => _PersonRegisterScreenState();
}

class _PersonRegisterScreenState extends State<PersonRegisterScreen> {
  late final PersonRegisterProvider _provider;
  bool _isFiltersExpanded = false;
  String _selectedOrgUnitId = '';
  String _selectedOrgUnitName = '';
  List<Map<String, dynamic>> _orgUnits = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final apiService = Dhis2ApiService();
    _provider = PersonRegisterProvider(apiService);
    _loadOrgUnits();
  }

  Future<void> _loadOrgUnits() async {
    try {
      final orgUnitsData = await _provider.apiService.getProgramOrgUnits(widget.programId);
      setState(() {
        _orgUnits = orgUnitsData;
        if (_orgUnits.isNotEmpty) {
          _selectedOrgUnitId = _orgUnits.first['id'];
          _selectedOrgUnitName = _orgUnits.first['name'];
          _loadPersons();
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load organization units: $e')),
        );
      }
    }
  }

  Future<void> _loadPersons() async {
    await _provider.loadPersons(
      programId: widget.programId,
      orgUnitId: _selectedOrgUnitId,
      searchText: _searchController.text.isNotEmpty ? _searchController.text : null,
    );
  }

  Person _mapToPerson(TrackedEntityInstance tei) {
    final enrollment = tei.enrollments.isNotEmpty ? tei.enrollments.first : null;
    
    return Person(
      id: tei.id,
      fullName: tei.attributes['X5UOKXdwvbI'] ?? 'Unknown',
      registrationDate: enrollment?.enrollmentDate.toString() ?? 'Unknown date',
      sex: tei.attributes['sMXnVr16R9k'],
      dob: tei.attributes['HYlWwg511tF'],
      updated: 'Recently updated',
      ownedBy: enrollment?.orgUnitName ?? _selectedOrgUnitName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        body: Column(
          children: [
            FilterHeader(
              isExpanded: _isFiltersExpanded,
              onToggle: () => setState(() => _isFiltersExpanded = !_isFiltersExpanded),
              selectedProgram: widget.programName,
              programs: [widget.programName],
              headerColor: widget.headerColor,
              onProgramChanged: (_) {},
              selectedOrgUnit: _selectedOrgUnitName,
              orgUnits: _orgUnits.map((ou) => ou['name'] as String).toList(),
              onOrgUnitChanged: (String? newValue) {
                if (newValue != null) {
                  final selectedOrg = _orgUnits.firstWhere((ou) => ou['name'] == newValue);
                  setState(() {
                    _selectedOrgUnitId = selectedOrg['id'];
                    _selectedOrgUnitName = selectedOrg['name'];
                  });
                  _loadPersons();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search persons...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _loadPersons();
                    },
                  ),
                ),
                onSubmitted: (_) => _loadPersons(),
              ),
            ),
            Expanded(
              child: Consumer<PersonRegisterProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.errorMessage != null) {
                    return Center(child: Text(provider.errorMessage!));
                  }
                  if (provider.persons.isEmpty) {
                    return const Center(child: Text('No persons found'));
                  }
                  
                  return ListView.builder(
                    itemCount: provider.persons.length,
                    itemBuilder: (context, index) {
                      final person = provider.persons[index];
                      return PersonListItem(
                        person: _mapToPerson(person),
                        programId: widget.programId,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}