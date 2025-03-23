class HabitEntity {
  final int? id;
  final String text;
  final String createdBy;
  final bool isCollaborative;
  final DateTime createdAt;

  HabitEntity({
    this.id,
    required this.text,
    required this.createdBy,
    required this.isCollaborative,
    required this.createdAt,
  });
}
