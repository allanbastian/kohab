import 'package:kohab/features/habits/data/models/habit_model.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';

class HabitMapper {
  static HabitEntity toEntity(HabitModel model) {
    return HabitEntity(
      id: model.id,
      text: model.text,
      createdBy: model.createdBy,
      isCollaborative: model.isCollaborative,
      createdAt: model.createdAt,
    );
  }
}
