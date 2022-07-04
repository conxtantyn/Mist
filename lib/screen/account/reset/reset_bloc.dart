import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../domain/domain.dart';

import 'reset_event.dart';
import 'reset_state.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  final PasswordResetUsecase _resetUsecase;

  ResetBloc(this._resetUsecase) : super(const ResetState());

  ResetBloc clone() => ResetBloc(this._resetUsecase);

  @override
  Stream<ResetState> mapEventToState(ResetEvent event) async* {
    if (event is UpdateFormEvent) {
      yield state.copyWith(
        loading: false,
        isFormValid: event.isValid,
        isResetSuccessful: false,
      );
    } else if (event is VerifyCodeEvent) {
      yield* _validateCode(event);
    } else if (event is OnResetEvent) {
      yield* _resetPassword(event);
    }
  }

  Stream<ResetState> _validateCode(VerifyCodeEvent event) async* {
    try {
      int.parse(event.code);
      yield state.copyWith(
        code: event.code,
        isPinValid: event.code.length == Constants.kOtpLength,
        loading: false,
        isResetSuccessful: false,
      );
    } catch (ex) {
      yield state.copyWith(
        isPinValid: false,
        loading: false,
        isResetSuccessful: false,
      );
    }
  }

  Stream<ResetState> _resetPassword(OnResetEvent event) async* {
    await Future.delayed(Duration(milliseconds: 500), () {});
    yield state.copyWith(loading: true, isResetSuccessful: false);
    try {
      yield await _resetUsecase
          .reset(event.code, event.password)
          .then((response) {
        return state.copyWith(
          loading: false,
          isResetSuccessful: true,
        );
      });
    } on Exception catch (ex) {
      yield state.copyWith(
        loading: false,
        isResetSuccessful: false,
        error: ex,
      );
    }
  }
}
