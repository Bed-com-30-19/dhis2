import 'package:flutter/material.dart';
import '../entities/person.dart';
import '../entities/program_stage.dart';

class ProgramProvider extends ChangeNotifier {
  late Person selectedPerson;
  final List<ProgramStage> _stages = [];

  List<ProgramStage> get stages => _stages;

  void loadPersonDetails(String personId) {
    // Simulate a person fetch
    selectedPerson = Person(
      id: personId,
      fullName: "Angela Chezale",
      registrationDate: "13/05/2025",
      dob: "",
      sex: "",
      updated: "",
      ownedBy: "Airwing Clinic (Zomba)",
    );

    notifyListeners();
  }

  void loadStages() {
    _stages.clear();
    _stages.addAll([
      ProgramStage(id: "1", title: "Population Segment and LLIN"),
      ProgramStage(id: "2", title: "Death"),
      ProgramStage(id: "3", title: "Vitals"),
      ProgramStage(id: "4", title: "Common Allergies"),
      ProgramStage(id: "5", title: "Vaccines"),
      ProgramStage(id: "6", title: "Non-Communicable Diseases"),
    ]);
    notifyListeners();
  }

  void addEvent(String stageId) {
    // You can add more logic here
    notifyListeners();
  }
}
