import 'package:get_it/get_it.dart';
import 'package:kohab/features/auth/data/datasources/services/auth_service.dart';
import 'package:kohab/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kohab/features/auth/domain/repositories/auth_repository.dart';
import 'package:kohab/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:kohab/features/auth/domain/usecases/login_usecase.dart';
import 'package:kohab/features/auth/domain/usecases/signup_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Services
  sl.registerSingleton<AuthService>(AuthServiceImpl());

  //Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //Usecase
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
}