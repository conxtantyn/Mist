import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_number/phone_number.dart';

import '../../../domain/domain.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthUsecase _authUsecase;

  LoginBloc(
    bool animated,
    this._authUsecase,
  ) : super(LoginState(animated: animated));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is InitializeEvent && state.animated) {
      await Future.delayed(event.duration, () {});
      yield state.copyWith(animated: false);
    } else if (event is ValidatePhoneEvent) {
      yield* _validatePhone(event);
    } else if (event is AuthenticateEvent) {
      yield* _authenticate(event);
    }
  }

  Stream<LoginState> _validatePhone(ValidatePhoneEvent event) async* {
    try {
      final result = await PhoneNumberUtil().parse(
        event.phone,
        regionCode: event.locale.countryCode,
      );
      yield state.copyWith(
        enabled: true,
        phone: result.e164,
        finished: false,
      );
    } catch (ex) {
      yield state.copyWith(
        enabled: false,
        phone: null,
        finished: false,
      );
    }
  }

  Stream<LoginState> _authenticate(AuthenticateEvent event) async* {
    yield state.copyWith(loading: true, finished: false);
    try {
      yield await _authUsecase.authenticate(event.phone, event.lang).then((_) {
        return state.copyWith(
          loading: false,
          enabled: true,
          finished: true,
        );
      });
    } on Exception catch (ex) {
      yield state.copyWith(
        loading: false,
        enabled: true,
        finished: false,
        error: ex,
      );
    }
  }
}
