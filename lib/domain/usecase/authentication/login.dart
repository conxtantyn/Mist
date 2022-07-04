import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:injectable/injectable.dart';

import '../../model/model.dart';
import '../../repository/authentication.dart';

import '../location.dart';

@injectable
class LoginUsecase {
  final AuthenticationRepository _repository;

  LoginUsecase(this._repository);

  Future<Attempt> authenticate(
    String number,
    String lang,
    String device,
    String address,
  ) {
    return _repository.sendOtp(number, lang, device, address);
  }
}

@injectable
class AuthUsecase {
  final LoginUsecase _loginUsecase;
  final GetDeviceLocationUsecase _deviceLocationUsecase;

  AuthUsecase(this._loginUsecase, this._deviceLocationUsecase);

  Future<Attempt> authenticate(String number, String lang) {
    return _deviceLocationUsecase.getLocation().then((location) async {
      final address = json.encode(location.address.toJson());
      final device = await _getDeviceType();
      return _loginUsecase.authenticate(number, lang, device, address);
    });
  }

  Future<String> _getDeviceType() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Device.get().isAndroid) {
      return (await deviceInfo.androidInfo).model;
    } else if (Device.get().isIos) {
      return (await deviceInfo.iosInfo).utsname.machine;
    }
    return 'unknown';
  }
}

@injectable
class LastLoginAttemptUsecase {
  final AuthenticationRepository _repository;

  LastLoginAttemptUsecase(this._repository);

  Future<Attempt> attempt() => _repository.lastLogInAttempt();
}
