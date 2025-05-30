import 'enrollment.dart';

class TrackedEntityInstance {
  final String id;
  final String orgUnit;
  final Map<String, dynamic> attributes;
  final List<Enrollment> enrollments;

  TrackedEntityInstance({
    required this.id,
    required this.orgUnit,
    required this.attributes,
    required this.enrollments,
  });

  factory TrackedEntityInstance.fromJson(Map<String, dynamic> json) {
    return TrackedEntityInstance(
      id: json['trackedEntityInstance'],
      orgUnit: json['orgUnit'],
      attributes: _parseAttributes(json['attributes'] ?? []),
      enrollments: _parseEnrollments(json['enrollments'] ?? []),
    );
  }

  static Map<String, dynamic> _parseAttributes(List<dynamic> attributes) {
    final Map<String, dynamic> result = {};
    for (var attr in attributes) {
      result[attr['attribute']] = attr['value'];
    }
    return result;
  }

  static List<Enrollment> _parseEnrollments(List<dynamic> enrollments) {
    return enrollments.map((e) => Enrollment.fromJson(e)).toList();
  }
}