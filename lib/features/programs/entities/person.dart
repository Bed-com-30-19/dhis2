class Person {
  final String id;
  final String fullName;
  final String registrationDate;
  final String? sex;
  final String? dob;
  final String updated;
  final String ownedBy;

  Person({
    required this.id,
    required this.fullName,
    required this.registrationDate,
    this.sex,
    this.dob,
    required this.updated,
    required this.ownedBy,
  });
}
