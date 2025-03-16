import 'package:dartz/dartz.dart';
import 'package:kohab/core/usecase/usecase.dart';
import 'package:kohab/features/habits/domain/repositories/habits_repository.dart';
import 'package:kohab/service_locator.dart';

class GetAllHabitsUsecase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return sl<HabitsRepository>().getAllUserHabits();
  }
}