class MappingRule {
  final String name;
  final DataElementReference source;
  final DataElementReference target;
  final List<String> transformations;

  MappingRule({
    required this.name,
    required this.source,
    required this.target,
    required this.transformations,
  });

  factory MappingRule.fromJson(Map<String, dynamic> json) {
    return MappingRule(
      name: json['name'],
      source: DataElementReference.fromJson(json['source']),
      target: DataElementReference.fromJson(json['target']),
      transformations: List<String>.from(json['transformations']),
    );
  }
}

class DataElementReference {
  final String dataElement;
  final String program;
  final String stage;

  DataElementReference({
    required this.dataElement,
    required this.program,
    required this.stage,
  });

  factory DataElementReference.fromJson(Map<String, dynamic> json) {
    return DataElementReference(
      dataElement: json['dataElement'],
      program: json['program'],
      stage: json['stage'],
    );
  }
}

class MappingRulesResponse {
  final List<MappingRule> mappingRules;
  final String orgUnit;

  MappingRulesResponse({
    required this.mappingRules,
    required this.orgUnit,
  });

  factory MappingRulesResponse.fromJson(Map<String, dynamic> json) {
    return MappingRulesResponse(
      mappingRules: (json['mappingRules'] as List)
          .map((rule) => MappingRule.fromJson(rule))
          .toList(),
      orgUnit: json['orgUnit'],
    );
  }
}