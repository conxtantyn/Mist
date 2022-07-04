import 'package:injectable/injectable.dart';

import '../../entity/entity.dart';
import '../../repository/authentication.dart';

import '../account/user.dart';

@injectable
class VerifyOtpUsecase {
  final AuthenticationRepository _repository;

  VerifyOtpUsecase(this._repository);

  Future<bool> verify(String otp) {
    return _repository.authorize(otp);
  }
}

@injectable
class ProcessOtpUsecase {
  final VerifyOtpUsecase _verifyOtpUsecase;
  final GetUserUsecase _getUserUsecase;

  ProcessOtpUsecase(this._verifyOtpUsecase, this._getUserUsecase);

  Future<Account> process(String otp) {
    return _verifyOtpUsecase.verify(otp).then((response) {
      return _getUserUsecase.getUser();
    });
  }
}
