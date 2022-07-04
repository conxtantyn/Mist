import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class InitializeEvent extends RegisterEvent {
  final Duration duration;

  InitializeEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

class UpdateFirstFormEvent extends RegisterEvent {
  final bool isValid;

  UpdateFirstFormEvent(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class UpdateSecondFormEvent extends RegisterEvent {
  final bool isValid;

  UpdateSecondFormEvent(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class UpdateThirdFormEvent extends RegisterEvent {
  final bool isValid;

  UpdateThirdFormEvent(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class OnSubmitEvent extends RegisterEvent {
  final String phone;
  final Map<String, String?> account;

  OnSubmitEvent(this.phone, this.account);

  @override
  List<Object> get props => [phone, account];
}

class OnRegisteredEvent extends RegisterEvent {}

class PreviousFormEvent extends RegisterEvent {}

class NextFormEvent extends RegisterEvent {}
