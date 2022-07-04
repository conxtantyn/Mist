import '../model/model.dart';

abstract class AuthenticationRepository {
  Future<bool> login(String password);

  Future<Attempt> sendOtp(
    String number,
    String lang,
    String device,
    String address,
  );

  Future<bool> authorize(String otp);

  Future<Attempt> lastLogInAttempt();

  Future<void> logout();
}
