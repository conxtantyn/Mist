import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitializeEvent extends LoginEvent {
  final Duration duration;

  InitializeEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

class ValidatePhoneEvent extends LoginEvent {
  final Locale locale;
  final String phone;

  const ValidatePhoneEvent(this.locale, this.phone);

  @override
  List<Object> get props => [phone];
}

class AuthenticateEvent extends LoginEvent {
  final String phone;

  final String lang;

  const AuthenticateEvent(this.phone, this.lang);

  @override
  List<Object> get props => [phone];
}
