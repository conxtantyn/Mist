import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class KBloc<Event, Action, State> extends Bloc<Event, State> {
  final Subject<Action?> _notifier = PublishSubject<Action?>();

  KBloc(State initialState) : super(initialState);

  Stream<Action?> get observer => _notifier.stream;

  void dispatch(Action action) => _notifier.add(action);

  @override
  Future<void> close() {
    _notifier.close();

    return super.close();
  }
}
