class ProgramStage {
  final String id;
  final String title;
  final String status;

  ProgramStage({
    required this.id,
    required this.title,
    this.status = "No data",
  });
}
