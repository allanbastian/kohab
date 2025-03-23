import 'package:dartz/dartz.dart';
import 'package:kohab/common/helpers/logger.dart';
import 'package:kohab/common/helpers/mappers/habit_mapper.dart';
import 'package:kohab/features/habits/data/models/habit_model.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';
import 'package:kohab/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HabitsService {
  Future<Either> getAllUserHabits();
  Future<Either> updateHabit(HabitEntity habitEntity);
  Future<Either> addNewHabit(HabitEntity entity);
  Future<Either> deleteHabit(int id);
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
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either> updateHabit(HabitEntity habitEntity) async {
    try {
      HabitModel model = HabitMapper.toModel(habitEntity);
      final result = await sl<SupabaseClient>().from('habits').update(model.toMap()).select();
      List<HabitModel> res = result.map((e) => HabitModel.fromMap(e)).toList();
      assert(res.length == 1); //Since we updated one habit, only one should be returned
      return Right(res.first);
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addNewHabit(HabitEntity entity) async {
    try {
      HabitModel model = HabitMapper.toModel(entity);
      final habitMap = model.toMap()..remove('id');
      final result = await sl<SupabaseClient>().from('habits').insert(habitMap).select();
      List<HabitModel> res = result.map((e) => HabitModel.fromMap(e)).toList();
      assert(res.length == 1);
      return Right(res.first);
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either> deleteHabit(int id) async {
    try {
      await sl<SupabaseClient>().from('habits').delete().eq('id', id);
      return const Right('success');
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }
}
