import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

class StartupEvent extends MainEvent {
  final Configuration configuration;

  final Account? account;

  StartupEvent(this.configuration, this.account);

  @override
  List<Object?> get props => [configuration, account];
}

class UpdateCountryCodeEvent extends MainEvent {
  final String countryCode;

  UpdateCountryCodeEvent(this.countryCode);

  @override
  List<Object?> get props => [countryCode];
}

class UpdateAccountEvent extends MainEvent {
  final Account account;

  UpdateAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}
