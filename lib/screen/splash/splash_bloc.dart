import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final StartupUsecase _startupUsecase;

  SplashBloc(this._startupUsecase) : super(const SplashState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is OnInitializeEvent) {
      yield* _initialize(event);
    }
  }

  Stream<SplashState> _initialize(OnInitializeEvent event) async* {
    final duration = Duration(milliseconds: 1000);
    final endDuration = Duration(
      milliseconds: (event.delay.inMilliseconds * 1.5).toInt(),
    );
    if (state.error == null) {
      await Future.delayed(event.delay, () {});
    }
    yield state.copyWith(isEnabled: true, error: null);
    await Future.delayed(duration, () {});
    yield state.copyWith(loading: true);
    try {
      final _state =
          await _startupUsecase.startup(event.locale).then((data) async {
        return state.copyWith(
          account: data.account,
          config: data.configuration,
        );
      });
      final __state = _state.copyWith(loading: false, isEnabled: false);
      yield __state;
      await Future.delayed(endDuration, () {});
      yield __state.copyWith(isReady: true);
    } on Exception catch (ex) {
      yield state.copyWith(loading: false, isEnabled: false, error: ex);
    }
  }
}
