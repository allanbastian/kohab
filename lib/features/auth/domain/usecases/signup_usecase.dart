import 'package:dartz/dartz.dart';
import 'package:kohab/core/usecase/usecase.dart';
import 'package:kohab/features/auth/data/models/sign_up_req_params.dart';
import 'package:kohab/features/auth/domain/repositories/auth_repository.dart';
import 'package:kohab/service_locator.dart';

class SignupUsecase extends UseCase<Either, SignUpReqParams> {
  
  @override
  Future<Either> call({SignUpReqParams? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
