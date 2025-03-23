import 'package:dartz/dartz.dart';
import 'package:kohab/core/usecase/usecase.dart';
import 'package:kohab/features/habits/domain/repositories/habits_repository.dart';
import 'package:kohab/service_locator.dart';

class DeleteHabitUsecase extends UseCase<Either, int>{
  @override
  Future<Either> call({int? params}) async {
    return await sl<HabitsRepository>().deleteHabit(params!);
  }
}