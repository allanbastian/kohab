import 'package:dartz/dartz.dart';
import 'package:kohab/core/usecase/usecase.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';
import 'package:kohab/features/habits/domain/repositories/habits_repository.dart';
import 'package:kohab/service_locator.dart';

class UpdateHabitUsecase extends UseCase<Either, HabitEntity> {
  @override
  Future<Either> call({HabitEntity? params}) async {
    return await sl<HabitsRepository>().updateHabit(params!);
  }
}