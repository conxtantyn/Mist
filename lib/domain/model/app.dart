import 'package:equatable/equatable.dart';

import '../entity/account.dart';

import 'config.dart';

class Startup extends Equatable {
  final Account? account;

  final Configuration configuration;

  Startup(this.account, this.configuration);

  @override
  List<Object?> get props => [account, configuration];
}
