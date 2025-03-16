part of 'habits_cubit.dart';

abstract class HabitsState {}

class HabitsInitial extends HabitsState {}

class HabitsLoading extends HabitsState {}

class HabitsLoaded extends HabitsState {
  final List<HabitEntity> habits;
  final List<HabitEntity> personalHabits;
  final List<HabitEntity> collabHabits;

  HabitsLoaded({
    required this.habits,
    required this.personalHabits,
    required this.collabHabits,
  });
}

class HabitsLoadingError extends HabitsState {
  final String error;

  HabitsLoadingError({required this.error});
}
