import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/program_provider.dart';

class ProgramStageList extends StatelessWidget {
  const ProgramStageList({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = context.watch<ProgramProvider>().stages;

    return ListView.builder(
      itemCount: stages.length,
      itemBuilder: (context, index) {
        final stage = stages[index];
        return ListTile(
          leading: const Icon(Icons.description, color: Colors.green),
          title: Text(stage.title),
          subtitle: Text(stage.status),
          trailing: IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
            onPressed: () {
              context.read<ProgramProvider>().addEvent(stage.id);
            },
          ),
        );
      },
    );
  }
}
