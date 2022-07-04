import 'package:equatable/equatable.dart';

abstract class RegistrationAction extends Equatable {
  const RegistrationAction();

  @override
  List<Object?> get props => [];
}

class PageUpdate extends RegistrationAction {
  final int page;

  PageUpdate(this.page);

  @override
  List<Object?> get props => [page];
}
