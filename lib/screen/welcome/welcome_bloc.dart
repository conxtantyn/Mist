import 'package:flutter_bloc/flutter_bloc.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState());

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
