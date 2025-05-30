import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../core/data_from_prefs/data_from_prefs.dart';
import '../programs/entities/tracked_entity_instance.dart';

class Dhis2ApiService {
  String _lastErrorMessage = '';
  String orgUnitId = "hrbAl7aUBwV";

  String get lastErrorMessage => _lastErrorMessage;

  Future<List<Map<String, dynamic>>> getPrograms() async {
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];

    if (authToken == null) throw Exception('Not authenticated');
    if (baseUrl == null) throw Exception('Base URL not configured');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/programs?fields=id,name,programType,displayName&paging=false'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['programs']);
      } else {
        _lastErrorMessage = 'Failed to load programs: ${response.statusCode} - ${response.body}';
        throw Exception(_lastErrorMessage);
      }
    } catch (e) {
      _lastErrorMessage = 'Error fetching programs: $e';
      throw Exception(_lastErrorMessage);
    }
  }

  Future<List<Map<String, dynamic>>> getProgramOrgUnits(String programId) async {
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];

    if (authToken == null) throw Exception('Not authenticated');
    if (baseUrl == null) throw Exception('Base URL not configured');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/programs/$programId/organisationUnits?fields=id,name,level,parent[id,name]&paging=false'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 20));
      // print('==================================================');
      // print('Response Body: ${response.body}');
      // print('==================================================');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['organisationUnits']);
      } else {
        _lastErrorMessage = 'Failed to load org units: ${response.statusCode} - ${response.body}';
        throw Exception(_lastErrorMessage);
      }
    } catch (e) {
      _lastErrorMessage = 'Error fetching org units: $e';
      throw Exception(_lastErrorMessage);
    }
  }

  Future<List<Map<String, dynamic>>> getTrackedEntityAttributes(String programId) async {
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];

    if (authToken == null) throw Exception('Not authenticated');
    if (baseUrl == null) throw Exception('Base URL not configured');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/programs/$programId?fields=programTrackedEntityAttributes[trackedEntityAttribute[id,name,valueType,code,optionSet[id,name]]'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final attributes = data['programTrackedEntityAttributes'] as List;
        return attributes.map((attr) => attr['trackedEntityAttribute'] as Map<String, dynamic>).toList();
      } else {
        _lastErrorMessage = 'Failed to load attributes: ${response.statusCode} - ${response.body}';
        throw Exception(_lastErrorMessage);
      }
    } catch (e) {
      _lastErrorMessage = 'Error fetching attributes: $e';
      throw Exception(_lastErrorMessage);
    }
  }

  Future<List<TrackedEntityInstance>> getRegisteredPersons({
    required String programId,
    String? searchText,
  }) async {
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];

    if (authToken == null) throw Exception('Not authenticated');
    if (baseUrl == null) throw Exception('Base URL not configured');

    try {
      String url = '$baseUrl/api/trackedEntityInstances?'
          'program=$programId&'
          'ou=$orgUnitId&'
          'ouMode=DESCENDANTS&'
          'fields=trackedEntityInstance,orgUnit,attributes[attribute,value],'
          'enrollments[enrollment,program,orgUnit,orgUnitName,enrollmentDate,status]';

      if (searchText != null && searchText.isNotEmpty) {
        url += '&filter=firstName:like:$searchText';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['trackedEntityInstances'] != null) {
          return (data['trackedEntityInstances'] as List)
              .map((tei) => TrackedEntityInstance.fromJson(tei))
              .toList();
        }
        return [];
      } else {
        throw Exception('Failed to load persons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching persons: $e');
    }
  }
  
  List<Map<String, dynamic>> _transformTeiData(List<dynamic> teiList) {
    return teiList.map((tei) {
      final attributes = <String, dynamic>{};
      if (tei['attributes'] != null) {
        for (var attr in tei['attributes']) {
          attributes[attr['attribute']] = attr['value'];
        }
      }

      final enrollments = <Map<String, dynamic>>[];
      if (tei['enrollments'] != null) {
        enrollments.addAll(tei['enrollments'].map((enrollment) => {
          'enrollment': enrollment['enrollment'],
          'program': enrollment['program'],
          'orgUnit': enrollment['orgUnit'],
          'orgUnitName': enrollment['orgUnitName'],
          'enrollmentDate': enrollment['enrollmentDate'],
          'status': enrollment['status'],
        }));
      }

      return {
        'id': tei['trackedEntityInstance'],
        'orgUnit': tei['orgUnit'],
        'attributes': attributes,
        'enrollments': enrollments,
      };
    }).toList();
  }

  Future<Map<String, dynamic>> getPersonDetails(String personId) async {
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];

    if (authToken == null) throw Exception('Not authenticated');
    if (baseUrl == null) throw Exception('Base URL not configured');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/trackedEntityInstances/$personId?fields=*'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        _lastErrorMessage = 'Failed to load person details: ${response.statusCode} - ${response.body}';
        throw Exception(_lastErrorMessage);
      }
    } catch (e) {
      _lastErrorMessage = 'Error fetching person details: $e';
      throw Exception(_lastErrorMessage);
    }
  }

  Future<bool> registerPerson(Map<String, dynamic> personData) async {
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];

    if (authToken == null) throw Exception('Not authenticated');
    if (baseUrl == null) throw Exception('Base URL not configured');

    try {
      final payload = {
        'trackedEntityType': personData['trackedEntityType'],
        'orgUnit': personData['orgUnit'],
        'attributes': personData['attributes'],
        'enrollments': [{
          'program': personData['program'],
          'orgUnit': personData['orgUnit'],
          'enrollmentDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'incidentDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        }],
      };

      final response = await http.post(
        Uri.parse('$baseUrl/api/trackedEntityInstances'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        _lastErrorMessage = 'Failed to register person: ${response.statusCode} - ${response.body}';
        return false;
      }
    } catch (e) {
      _lastErrorMessage = 'Error registering person: $e';
      return false;
    }
  }
}