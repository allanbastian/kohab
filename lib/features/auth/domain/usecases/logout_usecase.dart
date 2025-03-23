import 'package:dartz/dartz.dart';
import 'package:kohab/core/usecase/usecase.dart';
import 'package:kohab/features/auth/data/datasources/services/auth_service.dart';
import 'package:kohab/service_locator.dart';

class LogoutUsecase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthService>().signout();
  }

}