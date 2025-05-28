import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/program_provider.dart';

class PersonDetailsCard extends StatelessWidget {
  const PersonDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final person = context.watch<ProgramProvider>().selectedPerson;

    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Full name: ${person.fullName}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("Date of person registration: ${person.registrationDate}"),
          Text("Owned by: ${person.ownedBy}"),
        ],
      ),
    );
  }
}
