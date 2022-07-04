import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StateNotifier<T extends Equatable?> extends ChangeNotifier {
  T _state;

  StateNotifier(this._state) : super();

  T get state => _state;

  void update(T state) {
    if (this._state != state) {
      this._state = state;

      notifyListeners();
    }
  }
}
