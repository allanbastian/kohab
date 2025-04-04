import 'package:dartz/dartz.dart';
import 'package:kohab/common/helpers/logger.dart';
import 'package:kohab/features/auth/data/models/login_req_params.dart';
import 'package:kohab/features/auth/data/models/sign_up_req_params.dart';
import 'package:kohab/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  Future<Either> login(LoginReqParams params);
  Future<Either> signup(SignUpReqParams params);
  Future<Either> signout();
  Future<void> resetPassword(String email);
}

class AuthServiceImpl extends AuthService {
  final SupabaseClient _supabase = sl<SupabaseClient>();

  @override
  Future<Either> login(LoginReqParams params) async {
    try {
      var response = await _supabase.auth.signInWithPassword(email: params.email, password: params.password);
      return Right(response);
    } on AuthException catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left('${e.code}: ${e.message}');
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signup(SignUpReqParams params) async {
    try {
      var response = await _supabase.auth.signUp(email: params.email, password: params.password);
      return Right(response);
    } on AuthException catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      DebugLogger.log.logE(e);
      return Left('${e.code}: ${e.message}');
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signout() async {
    try {
      await _supabase.auth.signOut();
      return const Right('success');
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
      return Left(e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e, stackTrace) {
      DebugLogger.log.logE(e, stackTrace: stackTrace);
    }
  }
}
