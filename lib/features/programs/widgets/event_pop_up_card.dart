import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPopUpCard extends StatefulWidget {
  final String sectionTitle;
  final String programStageId;
  final String programId;
  final String teiId;

  const EventPopUpCard({
    super.key,
    required this.sectionTitle,
    required this.programStageId,
    required this.programId,
    required this.teiId,
  });

  @override
  State<EventPopUpCard> createState() => _EventPopUpCardState();
}

class _EventPopUpCardState extends State<EventPopUpCard> {
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _orgUnitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _eventDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _orgUnitController.text = 'Airwing Clinic (Zomba)';
  }

  @override
  void dispose() {
    _eventDateController.dispose();
    _orgUnitController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _eventDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sectionTitle, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                '22%',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String result) {
              print('Vitals menu selected: $result');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'Option 1', child: Text('Option 1')),
              const PopupMenuItem<String>(value: 'Option 2', child: Text('Option 2')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Event details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('2/2', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              TextField(
                controller: _eventDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Event date *',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          _eventDateController.clear();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _orgUnitController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Org unit *',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          _orgUnitController.clear();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.list),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Event data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('0/7', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              _buildDataInputField('Breathing rate'),
              _buildDataInputField('Body Temperature'),
              _buildDataInputField('Body Max Index'),
              _buildDataInputField('Blood pressure *'),
              _buildDataInputField('Heart rate *'),
              _buildDataInputField('Height'),
              _buildDataInputField('Weight'),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Vitals data saved!');
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Charts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildDataInputField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}