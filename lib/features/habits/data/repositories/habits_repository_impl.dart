import 'package:dartz/dartz.dart';
import 'package:kohab/common/helpers/mappers/habit_mapper.dart';
import 'package:kohab/features/habits/data/models/habit_model.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';
import 'package:kohab/features/habits/domain/repositories/habits_repository.dart';
import 'package:kohab/service_locator.dart';

class HabitsRepositoryImpl extends HabitsRepository {
  @override
  Future<Either> getAllUserHabits() async {
    final data = await sl<HabitsRepository>().getAllUserHabits();
    return data.fold(
      (err) => Left(err),
      (habits) {
        List<HabitEntity> habitEntities = [];
        for (HabitModel habit in habits) {
          HabitEntity entity = HabitMapper.toEntity(habit);
          habitEntities.add(entity);
        }
        return Right(habitEntities);
      },
    );
  }
}