import 'package:flutter/foundation.dart';
import '../../dhis2_service/dhis2_api_service.dart';

class ProgramStageProvider with ChangeNotifier {
  final Dhis2ApiService _apiService;
  List<Map<String, dynamic>> _programStages = [];
  bool _isLoading = false;
  String? _errorMessage;
  final Map<String, DateTime?> _scheduledDates = {};

  ProgramStageProvider(this._apiService);

  List<Map<String, dynamic>> get programStages => _programStages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, DateTime?> get scheduledDates => _scheduledDates;

  Future<void> loadProgramStages(String programId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _programStages = await _apiService.getProgramStages(programId);
      
      // Initialize scheduled dates for all stages
      for (var stage in _programStages) {
        _scheduledDates[stage['name']] = null;
      }
      
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> scheduleEvent(String stageName, DateTime date) async {
    _scheduledDates[stageName] = date;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getEventData({
    required String teiId,
    required String programId,
    required String programStageId,
  }) async {
    try {
      return await _apiService.getEventDataElements(
        teiId: teiId,
        programId: programId,
        programStageId: programStageId,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}