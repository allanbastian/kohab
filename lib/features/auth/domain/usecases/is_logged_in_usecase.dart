import 'package:kohab/core/usecase/usecase.dart';
import 'package:kohab/features/auth/domain/repositories/auth_repository.dart';
import 'package:kohab/service_locator.dart';

class IsLoggedInUsecase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}