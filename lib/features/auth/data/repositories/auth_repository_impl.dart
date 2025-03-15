import 'package:dartz/dartz.dart';
import 'package:kohab/features/auth/data/datasources/services/auth_service.dart';
import 'package:kohab/features/auth/data/models/login_req_params.dart';
import 'package:kohab/features/auth/data/models/sign_up_req_params.dart';
import 'package:kohab/features/auth/domain/repositories/auth_repository.dart';
import 'package:kohab/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl();

  @override
  Future<Either> login(LoginReqParams params) async {
    final data = await sl<AuthService>().login(params);
    return data.fold(
      (err) => Left(err),
      (data) async {
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool('isLoggedIn', true);
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signup(SignUpReqParams params) async {
    final data = await sl<AuthService>().signup(params);
    return data.fold(
      (err) => Left(err),
      (data) async {
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool('isLoggedIn', true);
        return Right(data);
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLoggedIn = sp.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  @override
  Future<Either> signout() async {
    final data = await sl<AuthService>().signout();
    return data.fold(
      (err) => Left(err),
      (data) async {
        final SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setBool('isLoggedIn', false);
        return Right(data);
      }
    );
  }

  @override
  Future<Either> getUserEmail() {
    // TODO: implement getUserEmail
    throw UnimplementedError();
  }
}
