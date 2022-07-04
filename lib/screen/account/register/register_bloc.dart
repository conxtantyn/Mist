import '../../../domain/domain.dart';

import '../../base/base.dart';

import 'register_event.dart';
import 'register_state.dart';
import 'register_action.dart';

class RegisterBloc
    extends KBloc<RegisterEvent, RegistrationAction, RegisterState> {
  final CreateUserUsecase _createUserUsecase;

  RegisterBloc(
    bool animated,
    this._createUserUsecase,
  ) : super(RegisterState(animated: animated));

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is InitializeEvent && state.animated) {
      await Future.delayed(event.duration, () {});
      yield state.copyWith(animated: false);
    } else if (event is UpdateFirstFormEvent) {
      yield state.copyWith(loading: false, isFirstFormValidated: event.isValid);
    } else if (event is UpdateSecondFormEvent) {
      yield state.copyWith(
        loading: false,
        isSecondFormValidated: event.isValid,
      );
    } else if (event is UpdateThirdFormEvent) {
      yield state.copyWith(loading: false, isThirdFormValidated: event.isValid);
    } else if (event is OnSubmitEvent) {
      yield* _register(event);
    } else if (event is NextFormEvent && state.page < 3) {
      final page = state.page + 1;
      yield state.copyWith(page: page, isThirdFormValidated: false);

      dispatch(PageUpdate(page));
    } else if (event is PreviousFormEvent && state.page > 1) {
      final page = state.page - 1;
      yield state.copyWith(page: page, isThirdFormValidated: false);

      dispatch(PageUpdate(page));
    }
  }

  Stream<RegisterState> _register(OnSubmitEvent event) async* {
    yield state.copyWith(loading: true, isRegistered: false);
    try {
      yield await _createUserUsecase
          .create(event.phone, event.account)
          .then((local) {
        return state.copyWith(loading: false, isRegistered: true);
      });
    } on Exception catch (ex) {
      yield state.copyWith(
        loading: false,
        isRegistered: false,
        error: ex,
      );
    }
  }
}
