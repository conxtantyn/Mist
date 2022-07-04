import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

class MainState extends Equatable {
  final Configuration? configuration;

  final Account? account;

  const MainState({
    this.configuration,
    this.account,
  });

  MainState copyWith({
    bool? initialized,
    Configuration? configuration,
    Account? account,
  }) =>
      MainState(
        configuration: configuration ?? this.configuration,
        account: account ?? this.account,
      );

  @override
  List<Object?> get props => [configuration, account];
}
