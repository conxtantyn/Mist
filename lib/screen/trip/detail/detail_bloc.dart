import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailState());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
