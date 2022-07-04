import '../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../../exception/exception.dart';

import '../../base/base.dart';

import 'verification_event.dart';
import 'verification_state.dart';
import 'verification_action.dart';

class VerificationBloc
    extends KBloc<VerificationEvent, VerificationAction, VerificationState> {
  final AuthUsecase _authUsecase;
  final ProcessOtpUsecase _processOtpUsecase;
  final LastLoginAttemptUsecase _attemptUsecase;

  VerificationBloc(
    this._authUsecase,
    this._processOtpUsecase,
    this._attemptUsecase,
  ) : super(const VerificationState());

  @override
  Stream<VerificationState> mapEventToState(VerificationEvent event) async* {
    if (event is InitializeEvent) {
      yield* _initialize(event);
    } else if (event is ValidateOtpEvent) {
      yield* _validateOtp(event);
    } else if (event is VerifyOtpEvent) {
      yield* _verifyOtp(event);
    } else if (event is ReAuthenticateEvent) {
      yield* _authenticate(event);
    }
  }

  Stream<VerificationState> _initialize(InitializeEvent event) async* {
    try {
      yield await _attemptUsecase.attempt().then((attempt) {
        return state.copyWith(
          phone: attempt.phone,
          duration: attempt.seconds,
        );
      });
    } on Exception catch (ex) {
      yield state.copyWith(
        loading: false,
        isUnVerifiable: ex is NoLoginAttemptException,
        error: ex,
      );
    }
  }

  Stream<VerificationState> _validateOtp(ValidateOtpEvent event) async* {
    try {
      int.parse(event.pin);
      yield state.copyWith(
        otp: event.pin,
        validated: event.pin.length == Constants.kOtpLength,
      );
    } catch (ex) {
      yield state.copyWith(validated: false);
    }
  }

  Stream<VerificationState> _verifyOtp(VerifyOtpEvent event) async* {
    yield state.copyWith(loading: true);
    try {
      final account = await _processOtpUsecase.process(event.pin);
      yield state.copyWith(loading: false);
      dispatch(VerifiedAction(account));
    } on Exception catch (ex) {
      yield state.copyWith(
        loading: false,
        isUnVerifiable: ex is NoLoginAttemptException,
        error: ex,
      );
    }
  }

  Stream<VerificationState> _authenticate(ReAuthenticateEvent event) async* {
    yield state.copyWith(resendingOtp: true);
    try {
      yield await _authUsecase
          .authenticate(event.phone, event.lang)
          .then((attempt) async {
        return state.copyWith(
          resendingOtp: false,
          phone: attempt.phone,
          duration: attempt.seconds,
        );
      });
    } on Exception catch (ex) {
      yield state.copyWith(
        resendingOtp: false,
        error: ex,
      );
    }
  }
}
