import 'package:equatable/equatable.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class InitializeEvent extends VerificationEvent {}

class ValidateOtpEvent extends VerificationEvent {
  final String pin;

  ValidateOtpEvent(this.pin);

  @override
  List<Object> get props => [pin];
}

class VerifyOtpEvent extends VerificationEvent {
  final String pin;

  VerifyOtpEvent(this.pin);

  @override
  List<Object> get props => [pin];
}

class ReAuthenticateEvent extends VerificationEvent {
  final String phone;

  final String lang;

  const ReAuthenticateEvent(this.phone, this.lang);

  @override
  List<Object> get props => [phone];
}
