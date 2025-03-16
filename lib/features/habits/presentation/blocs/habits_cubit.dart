import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';
import 'package:kohab/features/habits/domain/usecases/get_all_habits_usecase.dart';
import 'package:kohab/service_locator.dart';

part 'habits_state.dart';

class HabitsCubit extends Cubit<HabitsState> {
  HabitsCubit() : super(HabitsInitial());

  List<HabitEntity> currentHabits = [];
  List<HabitEntity> personalHabits = [];
  List<HabitEntity> collabHabits = [];

  void getAllUserHabits() async {
    emit(HabitsLoading());
    var data = await sl<GetAllHabitsUsecase>().call();
    data.fold(
      (err) => emit(HabitsLoadingError(error: err.toString())),
      (habits) {
        currentHabits = habits;
        personalHabits  = getPersonalHabits();
        collabHabits = getCollabHabits();
        emit(HabitsLoaded(habits: habits, personalHabits: personalHabits, collabHabits: collabHabits));
      },
    );
  }

  List<HabitEntity> getPersonalHabits() {
    return currentHabits.where((e) => !e.isCollaborative).toList();
  }

  List<HabitEntity> getCollabHabits() {
    return currentHabits.where((e) => e.isCollaborative).toList();
  }
}
