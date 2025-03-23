import 'package:kohab/features/habits/data/models/habit_model.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';

class HabitMapper {
  static HabitEntity toEntity(HabitModel model) {
    return HabitEntity(
      id: model.id,
      text: model.text ?? '',
      createdBy: model.createdBy ?? '',
      isCollaborative: model.isCollaborative ?? false,
      createdAt: model.createdAt ?? DateTime.now(),
    );
  }

  static HabitModel toModel(HabitEntity entity) {
    return HabitModel(
      id: entity.id,
      text: entity.text,
      createdBy: entity.createdBy,
      isCollaborative: entity.isCollaborative,
      createdAt: entity.createdAt,
    );
  }
}
