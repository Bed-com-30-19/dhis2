// person_register_provider.dart
import 'package:flutter/foundation.dart';
import '../../dhis2_service/dhis2_api_service.dart';
import '../entities/tracked_entity_instance.dart'; 

class PersonRegisterProvider with ChangeNotifier {
  final Dhis2ApiService apiService;
  List<TrackedEntityInstance> _persons = []; 
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedOrgUnit;
  String? _selectedProgram;
  String? _searchQuery;

  PersonRegisterProvider(this.apiService);

  List<TrackedEntityInstance> get persons => _persons;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedOrgUnit => _selectedOrgUnit;
  String? get selectedProgram => _selectedProgram;
  String? get searchQuery => _searchQuery;

  Future<void> loadPersons({
    required String programId,
    required String orgUnitId,
    String? searchText,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      _searchQuery = searchText;
      notifyListeners();

      _selectedProgram = programId;
      _selectedOrgUnit = orgUnitId;

      // if (kDebugMode) {
      //   print('==================================================');
      //   print('Loading persons for:');
      //   print('Program ID: $programId');
      //   print('Org Unit ID: $orgUnitId');
      //   print('Search Query: ${searchText ?? "None"}');
      //   print('==================================================');
      // }

      // Use the updated service method that returns List<TrackedEntityInstance>
      _persons = await apiService.getRegisteredPersons(
        programId: programId,
        searchText: searchText,
      );
      
      if (kDebugMode) {
        print('Loaded ${_persons.length} persons');
        if (_persons.isNotEmpty) {
          print('First person: ${_persons.first.attributes['name']}');
          print('First enrollment: ${_persons.first.enrollments.first.orgUnitName}');
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Error loading persons: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper method to find a person by ID
  TrackedEntityInstance? getPersonById(String id) {
    try {
      return _persons.firstWhere((person) => person.id == id);
    } catch (e) {
      return null;
    }
  }

  // Method to refresh the current list
  Future<void> refreshPersons() async {
    if (_selectedProgram != null && _selectedOrgUnit != null) {
      await loadPersons(
        programId: _selectedProgram!,
        orgUnitId: _selectedOrgUnit!,
        searchText: _searchQuery,
      );
    }
  }

  // Clear all data
  void clear() {
    _persons.clear();
    _errorMessage = null;
    _selectedOrgUnit = null;
    _selectedProgram = null;
    _searchQuery = null;
    notifyListeners();
  }
}