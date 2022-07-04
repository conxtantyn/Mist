import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../service/service.dart';

import '../base/base.dart';

import 'main_event.dart';
import 'main_state.dart';
import 'main_action.dart';

class MainBloc extends KBloc<MainEvent, MainAction, MainState> {
  final ApplicationService _appService;

  MainBloc(
    this._appService,
  ) : super(const MainState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is StartupEvent) {
      yield state.copyWith(
        configuration: event.configuration,
        account: event.account,
      );
      dispatch(NavigateToIndex(false, event.account));
    } else if (event is UpdateCountryCodeEvent) {
      yield state.copyWith(
        configuration: state.configuration?.copyWith(
          locale: Locale(
            state.configuration!.locale.languageCode,
            event.countryCode,
          ),
        ),
      );
    } else if (event is UpdateAccountEvent) {
      yield state.copyWith(account: event.account);

      dispatch(NavigateToIndex(true, event.account));
    }
  }

  @override
  Future<void> close() async {
    await _appService.dispose();
    return super.close();
  }
}
