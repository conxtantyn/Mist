import 'package:flutter_bloc/flutter_bloc.dart';

import 'request_event.dart';
import 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(const RequestState());

  @override
  Stream<RequestState> mapEventToState(RequestEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
