import 'package:dartz/dartz.dart';
import 'package:kohab/features/habits/data/models/habit_model.dart';
import 'package:kohab/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HabitsService {
  Future<Either> getAllUserHabits();
}

class HabitsServiceImpl extends HabitsService {
  @override
  Future<Either> getAllUserHabits() async {
    try {
      List<HabitModel> habits = [];
      String userId = sl<SupabaseClient>().auth.currentUser?.id ?? '';
      final result = await sl<SupabaseClient>().from('habits').select('*').eq('created_by', userId);
      for (var item in result) {
        HabitModel habit = HabitModel.fromMap(item);
        habits.add(habit);
      }
      return Right(habits);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
