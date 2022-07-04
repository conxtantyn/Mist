import 'package:equatable/equatable.dart';

abstract class ResetEvent extends Equatable {
  const ResetEvent();

  @override
  List<Object> get props => [];
}

class VerifyCodeEvent extends ResetEvent {
  final String code;

  VerifyCodeEvent(this.code);

  @override
  List<Object> get props => [code];
}

class UpdateFormEvent extends ResetEvent {
  final bool isValid;

  UpdateFormEvent(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class OnResetEvent extends ResetEvent {
  final String code;
  final String password;

  OnResetEvent(this.code, this.password);

  @override
  List<Object> get props => [code, password];
}
