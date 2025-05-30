class Enrollment {
  final String id;
  final String program;
  final String orgUnit;
  final String orgUnitName;
  final DateTime enrollmentDate;
  final String status;

  Enrollment({
    required this.id,
    required this.program,
    required this.orgUnit,
    required this.orgUnitName,
    required this.enrollmentDate,
    required this.status,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['enrollment'],
      program: json['program'],
      orgUnit: json['orgUnit'],
      orgUnitName: json['orgUnitName'],
      enrollmentDate: DateTime.parse(json['enrollmentDate']),
      status: json['status'],
    );
  }
}