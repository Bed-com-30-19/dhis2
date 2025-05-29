import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trackwise/core/data_from_prefs/data_from_prefs.dart';
import '../models/mapping_rule.dart'; // Import your local data source

class MappingService {
  final String datastoreNamespace = 'programMapping';
  final String datastoreKey = 'mapping_rules';

  MappingService(); // No constructor parameters needed now

  Future<List<MappingRule>> _fetchAllRules() async {
    // Get auth data directly from local storage
    final authData = await DataFromPrefs.getAuthData();
    final baseUrl = authData['baseUrl'];
    final authToken = authData['token'];

    if (baseUrl == null || authToken == null) {
      throw Exception('Authentication data not found. Please login again.');
    }

    final url = Uri.parse('$baseUrl/api/33/dataStore/$datastoreNamespace/$datastoreKey');
    final response = await http.get(
      url,
      headers: {
        'Authorization': authToken,
        'Content-Type': 'application/json',
      }
    );

    print('===============================================================================================================');
    print('AuthData: $authData');
    print('===============================================================================================================');
    print('Base Url: $baseUrl');
    print('===============================================================================================================');
    print('Token: ${response.body}');
    print('===============================================================================================================');
    print('Token: $authToken');
    print('===============================================================================================================');
    
    print('Basic Auth Token: basicAuth');
    print('===============================================================================================================');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['mappingRules'] as List)
          .map((rule) => MappingRule.fromJson(rule))
          .toList();
    }
    throw Exception('Failed to load mapping rules. Status: ${response.statusCode}');
  }

  // Rest of your existing methods remain unchanged
  Future<Map<String, dynamic>> mapDataAutomatically({
    required String triggerProgramId,
    required String triggerStageId,
    required Map<String, dynamic> inputData,
  }) async {
    final rules = await _fetchAllRules();
    final mappedData = <String, dynamic>{};

    for (final rule in rules) {
      final isSourceTrigger = rule.source.program == triggerProgramId && 
                            rule.source.stage == triggerStageId;
      final isTargetTrigger = rule.target.program == triggerProgramId && 
                             rule.target.stage == triggerStageId;

      if (isSourceTrigger && inputData.containsKey(rule.source.dataElement)) {
        mappedData[rule.target.dataElement] = inputData[rule.source.dataElement];
      } 
      else if (isTargetTrigger && inputData.containsKey(rule.target.dataElement)) {
        mappedData[rule.source.dataElement] = inputData[rule.target.dataElement];
      }
    }

    return mappedData;
  }
}