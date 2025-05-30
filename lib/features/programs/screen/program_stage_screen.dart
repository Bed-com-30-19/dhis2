import 'package:flutter/material.dart';

class VitalsFormPage extends StatefulWidget {
  const VitalsFormPage({super.key});

  @override
  State<VitalsFormPage> createState() => _VitalsFormPageState();
}

class _VitalsFormPageState extends State<VitalsFormPage> {
  DateTime selectedDate = DateTime(2025, 5, 27);
  String orgUnit = "Airwing Clinic (Zomba)";
  final TextEditingController breathingRateController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Vitals', style: TextStyle(color: Colors.white)),
        leading: const BackButton(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.circle, size: 36, color: Colors.white24),
                const Text('22%', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Form'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Charts'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
        ],
        currentIndex: 0,
        onTap: (_) {},
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // Save logic here
        },
        child: const Icon(Icons.save),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Event details", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _formField(
            label: "Event date *",
            value: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            icon: Icons.calendar_today,
            onTap: _pickDate,
          ),
          const SizedBox(height: 8),
          _formField(
            label: "Org unit *",
            value: orgUnit,
            icon: Icons.location_on,
            onTap: () {
              // Handle org unit selection
            },
          ),
          const SizedBox(height: 24),
          const Text("Event data", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _inputField("Breathing rate", breathingRateController),
          _inputField("Body Temperature", temperatureController),
          _inputField("Body Max Index", bmiController),
          _inputField("Blood pressure *", bloodPressureController),
        ],
      ),
    );
  }

  Widget _formField({required String label, required String value, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value),
            Icon(icon, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.blueGrey.shade50,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
