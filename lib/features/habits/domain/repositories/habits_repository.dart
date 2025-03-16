import 'package:dartz/dartz.dart';

abstract class HabitsRepository {
  Future<Either> getAllUserHabits();
}