import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class PageState extends Equatable {}

class LoginState extends PageState {
  final bool enabled;

  final bool loading;

  final bool finished;

  final bool animated;

  final String? phone;

  final Exception? error;

  LoginState({
    this.enabled = false,
    this.loading = false,
    this.finished = false,
    required this.animated,
    this.phone,
    this.error,
  });

  LoginState copyWith({
    bool? enabled,
    bool? loading,
    bool? finished,
    bool? animated,
    String? phone,
    Locale? locale,
    Exception? error,
  }) =>
      LoginState(
        enabled: enabled ?? this.enabled,
        loading: loading ?? this.loading,
        finished: finished ?? this.finished,
        animated: animated ?? this.animated,
        phone: phone ?? this.phone,
        error: error,
      );

  @override
  List<Object?> get props => [
        enabled,
        loading,
        finished,
        animated,
        phone,
      ];
}
