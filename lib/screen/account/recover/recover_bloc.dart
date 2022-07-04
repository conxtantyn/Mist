import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

import 'recover_event.dart';
import 'recover_state.dart';

class RecoverBloc extends Bloc<RecoverEvent, RecoverState> {
  final PasswordRecoveryUsecase _recoveryUsecase;

  RecoverBloc(this._recoveryUsecase) : super(const RecoverState());

  @override
  Stream<RecoverState> mapEventToState(RecoverEvent event) async* {
    if (event is UpdateFormEvent) {
      yield state.copyWith(
        loading: false,
        isValidated: event.isValid,
        requestedRecovery: false,
      );
    } else if (event is OnRecover) {
      yield* _recover(event);
    }
  }

  Stream<RecoverState> _recover(OnRecover event) async* {
    yield state.copyWith(loading: true, requestedRecovery: false);
    try {
      yield await _recoveryUsecase.recover(event.username).then((response) {
        return state.copyWith(
          loading: false,
          requestedRecovery: true,
        );
      });
    } on Exception catch (ex) {
      yield state.copyWith(
        loading: false,
        requestedRecovery: false,
        error: ex,
      );
    }
  }
}
