import 'package:dartz/dartz.dart';
import 'package:kohab/features/auth/data/datasources/services/auth_service.dart';
import 'package:kohab/features/auth/data/models/login_req_params.dart';
import 'package:kohab/features/auth/data/models/sign_up_req_params.dart';
import 'package:kohab/features/auth/domain/repositories/auth_repository.dart';
import 'package:kohab/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl();

  @override
  Future<Either> login(LoginReqParams params) async {
    return await sl<AuthService>().login(params);
  }

  @override
  Future<Either> signup(SignUpReqParams params) async {
    return await sl<AuthService>().signup(params);
  }

  @override
  Future<Either> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

  @override
  Future<Either> getUserEmail() {
    // TODO: implement getUserEmail
    throw UnimplementedError();
  }
}
