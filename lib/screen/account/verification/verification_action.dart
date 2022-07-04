import 'package:equatable/equatable.dart';

import '../../../domain/domain.dart';

abstract class VerificationAction extends Equatable {
  const VerificationAction();

  @override
  List<Object?> get props => [];
}

class VerifiedAction extends VerificationAction {
  final Account account;

  VerifiedAction(this.account);
}
