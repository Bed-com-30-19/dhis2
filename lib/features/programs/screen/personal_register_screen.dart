import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dhis2_service/dhis2_api_service.dart';
import '../entities/person.dart';
import '../provider/personal_register_provider.dart';
import '../widgets/filter_header.dart';
import '../widgets/personal_list_item.dart';

class PersonRegisterScreen extends StatefulWidget {
  final String programId;
  final String programName;

  const PersonRegisterScreen({
    super.key,
    required this.programId,
    required this.programName,
  });

  @override
  State<PersonRegisterScreen> createState() => _PersonRegisterScreenState();
}

class _PersonRegisterScreenState extends State<PersonRegisterScreen> {
  late final PersonRegisterProvider _provider;
  bool _isFiltersExpanded = false;
  String _selectedOrgUnit = '';
  List<String> orgUnits = []; // Changed from final _orgUnits to mutable orgUnits
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
        orgUnits = orgUnitsData.map((ou) => ou['name'] as String).toList();
        if (orgUnits.isNotEmpty) {
          _selectedOrgUnit = orgUnits.first;
          _provider.loadPersons(
            programId: widget.programId,
            orgUnitId: orgUnitsData.first['id'],
          );
        }
      });
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load organization units: $e')),
        );
      }
    }
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
              onProgramChanged: (_) {}, // Not changing program in this screen
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
                      _provider.loadPersons(
                        programId: widget.programId,
                        orgUnitId: _selectedOrgUnit,
                      );
                    },
                  ),
                ),
                onSubmitted: (value) {
                  _provider.loadPersons(
                    programId: widget.programId,
                    orgUnitId: _selectedOrgUnit,
                    searchText: value,
                  );
                },
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
                        person: Person(
                          id: person['trackedEntityInstance'],
                          fullName: _getPersonName(person),
                          registrationDate: _getEnrollmentDate(person),
                          sex: _getAttributeValue(person, 'gender'),
                          dob: _getAttributeValue(person, 'dateOfBirth'),
                          updated: 'Recently updated',
                          ownedBy: widget.programName,
                        ),
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

  String _getPersonName(Map<String, dynamic> person) {
    final firstName = _getAttributeValue(person, 'firstName');
    final lastName = _getAttributeValue(person, 'lastName');
    return '$firstName $lastName'.trim();
  }

  String _getEnrollmentDate(Map<String, dynamic> person) {
    if (person['enrollments'] != null && person['enrollments'].isNotEmpty) {
      return person['enrollments'][0]['enrollmentDate'] ?? 'Unknown date';
    }
    return 'Unknown date';
  }

  String? _getAttributeValue(Map<String, dynamic> person, String attribute) {
    if (person['attributes'] != null) {
      for (var attr in person['attributes']) {
        if (attr['attribute'] == attribute) {
          return attr['value']?.toString();
        }
      }
    }
    return null;
  }
}