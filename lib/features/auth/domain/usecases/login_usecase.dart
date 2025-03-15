import 'package:dartz/dartz.dart';
import 'package:kohab/core/usecase/usecase.dart';
import 'package:kohab/features/auth/data/models/login_req_params.dart';
import 'package:kohab/features/auth/domain/repositories/auth_repository.dart';
import 'package:kohab/service_locator.dart';

class LoginUsecase extends UseCase<Either, LoginReqParams> {
  @override
  Future<Either> call({LoginReqParams? params}) async {
    return await sl<AuthRepository>().login(params!);
  }
}
