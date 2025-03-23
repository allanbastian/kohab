import 'package:get_it/get_it.dart';
import 'package:kohab/features/auth/data/datasources/services/auth_service.dart';
import 'package:kohab/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kohab/features/auth/domain/repositories/auth_repository.dart';
import 'package:kohab/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:kohab/features/auth/domain/usecases/login_usecase.dart';
import 'package:kohab/features/auth/domain/usecases/signup_usecase.dart';
import 'package:kohab/features/habits/data/datasources/habits_service.dart';
import 'package:kohab/features/habits/data/repositories/habits_repository_impl.dart';
import 'package:kohab/features/habits/domain/repositories/habits_repository.dart';
import 'package:kohab/features/habits/domain/usecases/add_new_habit_usecase.dart';
import 'package:kohab/features/habits/domain/usecases/get_all_habits_usecase.dart';
import 'package:kohab/features/habits/domain/usecases/update_habit_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Services
  sl.registerSingleton<AuthService>(AuthServiceImpl());
  sl.registerSingleton<HabitsService>(HabitsServiceImpl());

  //Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<HabitsRepository>(HabitsRepositoryImpl());

  //Usecase
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  sl.registerSingleton<GetAllHabitsUsecase>(GetAllHabitsUsecase());
  sl.registerSingleton<AddNewHabitUsecase>(AddNewHabitUsecase());
  sl.registerSingleton<UpdateHabitUsecase>(UpdateHabitUsecase());
}