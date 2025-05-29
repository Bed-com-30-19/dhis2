import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/data_from_prefs/data_from_prefs.dart';

class Dhis2ApiService {
  

  Dhis2ApiService();

  

  Future<List<Map<String, dynamic>>> getPrograms() async {
    // Get auth data directly from local storage
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
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final programs = List<Map<String, dynamic>>.from(data['programs']);
        
        // If you want to process the first program in the list
        // if (programs.isNotEmpty) {
        //   //final firstProgram = programs.first;
        //   final String programId = 'NFnp1h3IMzl';
          
        //   final pgOrgUnits = await getProgramOrgUnits(programId);
        //   final tei = await getTrackedEntityAttributes(programId);
        //   final dataElements = await getProgramStageDataElements(programId);

        //   print('===============================================================================================================');
        //   print('Org Unit Data: $pgOrgUnits');
        //   print('===============================================================================================================');
        //   print('Tracked Entity Data: $tei');
        //   print('===============================================================================================================');
        //   print('Data Elements: $dataElements');
        //   print('===============================================================================================================');
        //   print('Token: $authToken');
        //   print('===============================================================================================================');
        //   print('Basic Auth Token: basicAuth');
        //   print('===============================================================================================================');
        // }

        return programs;
      } else {
        throw Exception('Failed to load programs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching programs: $e');
    }
  }
  // Fetch organization units for a specific program
  Future<List<Map<String, dynamic>>> getProgramOrgUnits(String programId) async {
    // Get auth data directly from local storage
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];
    if (authToken == null) throw Exception('Not authenticated');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl//api/programs/orgUnits?programs=$programId'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['organisationUnits']);
      } else {
        throw Exception('Failed to load program org units: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching program org units: $e');
    }
  }

  // Fetch tracked entity attributes for a program
  Future<List<Map<String, dynamic>>> getTrackedEntityAttributes(String programId) async {
    // Get auth data directly from local storage
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];
    if (authToken == null) throw Exception('Not authenticated');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/programs/$programId?fields=programTrackedEntityAttributes[trackedEntityAttribute[id,name,valueType]]'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final attributes = data['programTrackedEntityAttributes'] as List;
        return attributes.map((attr) => attr['trackedEntityAttribute'] as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load attributes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching attributes: $e');
    }
  }

  // Fetch data elements for program stages in a program
  Future<List<Map<String, dynamic>>> getProgramStageDataElements(String programId) async {
    // Get auth data directly from local storage
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];
    if (authToken == null) throw Exception('Not authenticated');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/programs/$programId?fields=programStages[programStageDataElements[dataElement[id,name,valueType]]'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stages = data['programStages'] as List;
        final elements = <Map<String, dynamic>>[];
        
        for (var stage in stages) {
          final stageElements = stage['programStageDataElements'] as List;
          elements.addAll(stageElements.map((e) => e['dataElement'] as Map<String, dynamic>));
        }
        
        return elements;
      } else {
        throw Exception('Failed to load data elements: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data elements: $e');
    }
  }

  //get tei attributes
  Future<Map<String, dynamic>> getPersonDetails(String personId) async {
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];
    if (authToken == null) throw Exception('Not authenticated');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/trackedEntityInstances/$personId'),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load person details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching person details: $e');
    }
  }

  // Add to Dhis2ApiService class
  Future<List<Map<String, dynamic>>> getRegisteredPersons({
    required String programId,
    required String orgUnitId,
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
        url += '&query=$searchText';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['trackedEntityInstances'] != null) {
          return List<Map<String, dynamic>>.from(data['trackedEntityInstances']);
        }
        return [];
      } else {
        throw Exception('Failed to load persons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching persons: $e');
    }
  }
}