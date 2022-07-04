import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

import 'password_event.dart';
import 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordLoginUsecase _loginUsecase;

  PasswordBloc(this._loginUsecase) : super(const PasswordState());

  @override
  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    if (event is UpdateFormEvent) {
      yield state.copyWith(
        loading: false,
        isValidated: event.isValid,
        isAuthenticated: false,
      );
    } else if (event is OnLogin) {
      yield* _login(event);
    }
  }

  Stream<PasswordState> _login(OnLogin event) async* {
    yield state.copyWith(loading: true, isAuthenticated: false);
    try {
      yield await _loginUsecase.authenticate(event.password).then((response) {
        return state.copyWith(
          loading: false,
          isAuthenticated: response,
        );
      });
    } on Exception catch (ex) {
      yield state.copyWith(
        loading: false,
        isAuthenticated: false,
        error: ex,
      );
    }
  }
}
