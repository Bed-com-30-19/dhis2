import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/programe_stage_adapter.dart';
import 'event_schedular_screen.dart';
import 'refferal_screen.dart';
import '../widgets/event_pop_up_card.dart';
import '../entities/person.dart';

class ProgramStageScreen extends StatefulWidget {
  final Person person;
  final String programId;

  const ProgramStageScreen({
    super.key,
    required this.person,
    required this.programId,
  });

  @override
  State<ProgramStageScreen> createState() => _ProgramStageScreenState();
}

class _ProgramStageScreenState extends State<ProgramStageScreen> {
  @override
  void initState() {
    super.initState();
    // Load program stages when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgramStageProvider>(context, listen: false)
          .loadProgramStages(widget.programId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final registrationDate = widget.person.registrationDate;
    final formattedDate = registrationDate.length > 10 
        ? registrationDate.substring(0, 10) 
        : registrationDate;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(''),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              'Edit person',
              style: TextStyle(color: Colors.white),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String result) {
              print('Selected: $result');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Refresh this record',
                child: ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Refresh this record'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Mark for follow-up',
                child: ListTile(
                  leading: Icon(Icons.flag),
                  title: Text('Mark for follow-up'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'View timeline',
                child: ListTile(
                  leading: Icon(Icons.timeline),
                  title: Text('View timeline'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Show help',
                child: ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Show help'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'More enrollments',
                child: ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('More enrollments'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Share',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Complete',
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text('Complete'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Deactivate',
                child: ListTile(
                  leading: Icon(Icons.cancel_outlined),
                  title: Text('Deactivate'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<ProgramStageProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full name: ${widget.person.fullName}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date of person registration: $formattedDate',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Owned by: ${widget.person.ownedBy}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.programStages.length,
                  itemBuilder: (context, index) {
                    final stage = provider.programStages[index];
                    final stageName = stage['name'];
                    final hasScheduledDate = provider.scheduledDates[stageName] != null;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.description, size: 40, color: Colors.green),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stageName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      if (!hasScheduledDate)
                                        const Text(
                                          'No data',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (String result) async {
                                    if (result == 'Enter event') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventPopUpCard(
                                            sectionTitle: stageName,
                                            programStageId: stage['id'],
                                            programId: widget.programId,
                                            teiId: widget.person.id,
                                          ),
                                        ),
                                      );
                                    } else if (result == 'Schedule event') {
                                      final DateTime? selectedDate = await showDialog<DateTime>(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return const ScheduleEventScreen();
                                        },
                                      );
                                      if (selectedDate != null) {
                                        provider.scheduleEvent(stageName, selectedDate);
                                      }
                                    } else if (result == 'Refer event') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ReferralScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'Enter event',
                                      child: ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text('Enter event'),
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'Schedule event',
                                      child: ListTile(
                                        leading: Icon(Icons.calendar_today),
                                        title: Text('Schedule event'),
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'Refer event',
                                      child: ListTile(
                                        leading: Icon(Icons.arrow_forward),
                                        title: Text('Refer event'),
                                      ),
                                    ),
                                  ],
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(2),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (hasScheduledDate)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Scheduled for ${DateFormat('dd/MM/yyyy').format(provider.scheduledDates[stageName]!)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Registered in: ${widget.person.ownedBy}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Today',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Not synced',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Center(
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EventPopUpCard(
                                                  sectionTitle: stageName,
                                                  programStageId: stage['id'],
                                                  programId: widget.programId,
                                                  teiId: widget.person.id,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                          label: const Text(
                                            'Enter event',
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
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
}