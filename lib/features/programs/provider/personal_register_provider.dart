// person_register_provider.dart
import 'package:flutter/foundation.dart';
import '../../dhis2_service/dhis2_api_service.dart';

class PersonRegisterProvider with ChangeNotifier {
  final Dhis2ApiService apiService; // Changed from _apiService to apiService
  List<Map<String, dynamic>> _persons = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedOrgUnit;
  String? _selectedProgram;

  PersonRegisterProvider(this.apiService); // Updated parameter name

  List<Map<String, dynamic>> get persons => _persons;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedOrgUnit => _selectedOrgUnit;
  String? get selectedProgram => _selectedProgram;

  Future<void> loadPersons({
    required String programId,
    required String orgUnitId,
    String? searchText,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedProgram = programId;
      _selectedOrgUnit = orgUnitId;

      _persons = await apiService.getRegisteredPersons(
        programId: programId,
        orgUnitId: orgUnitId,
        searchText: searchText,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}