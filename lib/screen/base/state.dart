import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/common.dart';
import '../../domain/domain.dart';
import '../../validator/validator.dart';

abstract class BaseState<T extends StatefulWidget, B extends Bloc,
    S extends Equatable> extends State<T> {
  final List<StreamSubscription<dynamic>> steams = [];

  S? _currentState;

  B? _bloc;

  bool disposed = false;

  @override
  void initState() {
    _bloc = context.read<B>();
    context.read<B>().stream.listen((state) {
      if (state is S) {
        if (state == _currentState || disposed) return;
        _currentState = state;
        onChange(state);
      }
    });
    super.initState();
  }

  @mustCallSuper
  void onChange(S state) {}

  void close() {
    _bloc?.close();
  }

  @override
  void dispose() {
    disposed = true;
    for (var i = 0; i < steams.length; i++) {
      steams.elementAt(i).cancel();
    }
    this.close();
    super.dispose();
  }
}

abstract class FormBlocState<T extends StatefulWidget, B extends Bloc,
    E extends Equatable, S extends Equatable> extends BaseState<T, B, S> {
  final Map<String, EditField> _formFields = {};

  final StateNotifier<FormData?> notifier = StateNotifier(null);

  @override
  void initState() {
    notifier.addListener(_onFormUpdated);
    super.initState();
  }

  void _onFormUpdated() {
    if (notifier.state == null) return;
    final prev = _formFields[notifier.state!.name];
    if (prev == notifier.state!.field) return;
    _formFields[notifier.state!.name] = notifier.state!.field;
    context.read<B>().add(formEvent(_isFormValid()));
  }

  E formEvent(bool isValid);

  bool _isFormValid() {
    if (!notifier.state!.field.isValid) return false;
    final keys = _formFields.keys;
    for (int i = 0; i < keys.length; i++) {
      if (!_formFields[keys.elementAt(i)]!.isValid) {
        return false;
      }
    }
    return _formFields.isNotEmpty;
  }
}
