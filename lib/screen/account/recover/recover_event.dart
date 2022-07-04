import 'package:equatable/equatable.dart';

abstract class RecoverEvent extends Equatable {
  const RecoverEvent();

  @override
  List<Object> get props => [];
}

class UpdateFormEvent extends RecoverEvent {
  final bool isValid;

  UpdateFormEvent(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class OnRecover extends RecoverEvent {
  final String username;

  OnRecover(this.username);

  @override
  List<Object> get props => [username];
}
