import 'package:dartz/dartz.dart';
import 'package:kohab/features/auth/data/models/login_req_params.dart';
import 'package:kohab/features/auth/data/models/sign_up_req_params.dart';

abstract class AuthRepository {
  Future<Either> signup(SignUpReqParams params);
  Future<Either> login(LoginReqParams params);
  Future<Either> signout();
  Future<Either> getUserEmail();
}
