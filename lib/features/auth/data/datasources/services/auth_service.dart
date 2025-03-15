import 'package:dartz/dartz.dart';
import 'package:kohab/features/auth/data/models/login_req_params.dart';
import 'package:kohab/features/auth/data/models/sign_up_req_params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  Future<Either> login(LoginReqParams params);
  Future<Either> signup(SignUpReqParams params);
}

class AuthServiceImpl extends AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<Either> login(LoginReqParams params) async {
    try {
      var response = await _supabase.auth.signInWithPassword(email: params.email, password: params.password);
      return Right(response);
    } on AuthException catch (e) {
      return Left('${e.code}: ${e.message}');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signup(SignUpReqParams params) async {
    try {
      var response = await _supabase.auth.signUp(email: params.email, password: params.password);
      return Right(response);
    } on AuthException catch (e) {
      return Left('${e.code}: ${e.message}');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
