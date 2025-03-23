import 'package:dartz/dartz.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';

abstract class HabitsRepository {
  Future<Either> getAllUserHabits();
  Future<Either> addNewHabit(HabitEntity entity);
  Future<Either> updateHabit(HabitEntity entity);
}
