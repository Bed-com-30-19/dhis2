import 'package:flutter/material.dart';

class EnrollmentListScreen extends StatelessWidget {
  const EnrollmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const BackButton(color: Colors.white),
        title: const Text("Enrollment list", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("All enrollments", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Show dashboard with all active programs"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          const Divider(thickness: 1),
          _sectionHeader("Active programs"),
          _activeProgramTile("3) Person Register", "Airwing Clinic\n(Zomba)", "13/05/2025"),
          _sectionHeader("Programs to enroll"),
          _programWithEnrollField("4-0) IMCI - Integrated Community Case Management", Icons.volunteer_activism, Colors.pink),
          _programWithEnrollField("5) EPI - Expanded Programme on Immunization", Icons.vaccines, Colors.blue),
          _programWithEnrollField("6.2) eIDSR Case Based Surveillance", Icons.local_hospital, Colors.blueAccent),
          _programWithEnrollField("7.1) CBMNC - Woman Program", Icons.pregnant_woman, Colors.pinkAccent),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _activeProgramTile(String title, String subtitle, String date) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(Icons.group, color: Colors.green),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(date),
    );
  }

  Widget _programWithEnrollField(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: 120,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[50],
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Enroll",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}