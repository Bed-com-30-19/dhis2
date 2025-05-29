// person_list_item.dart
import 'package:flutter/material.dart';
import '../entities/person.dart';

class PersonListItem extends StatelessWidget {
  final Person person;

  const PersonListItem({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full name: ${person.fullName}", 
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            if (person.sex != null) Text("Sex: ${person.sex}"),
            if (person.dob != null) Text("Date of birth: ${person.dob}"),
            Text("Registered on: ${person.registrationDate}"),
            Text("Program: ${person.ownedBy}"),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight, 
              child: Text(person.updated, style: const TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}