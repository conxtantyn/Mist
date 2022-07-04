import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

abstract class MainAction extends Equatable {
  const MainAction();

  @override
  List<Object?> get props => [];
}

class NavigateToIndex extends MainAction {
  final bool transition;
  final Account? account;

  NavigateToIndex(this.transition, this.account);

  @override
  List<Object?> get props => [transition, account];
}
