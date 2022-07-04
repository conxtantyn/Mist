import 'package:flutter_bloc/flutter_bloc.dart';

import 'requests_event.dart';
import 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc() : super(const RequestsState());

  @override
  Stream<RequestsState> mapEventToState(RequestsEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
