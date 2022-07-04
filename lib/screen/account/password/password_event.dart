import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdateFormEvent extends PasswordEvent {
  final bool isValid;

  UpdateFormEvent(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class OnLogin extends PasswordEvent {
  final String password;

  OnLogin(this.password);

  @override
  List<Object> get props => [password];
}
