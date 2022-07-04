import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

class SplashState extends Equatable {
  final bool loading;

  final bool isEnabled;

  final bool isReady;

  final Account? account;

  final Configuration? config;

  final Exception? error;

  const SplashState({
    this.loading = false,
    this.isEnabled = false,
    this.isReady = false,
    this.account,
    this.config,
    this.error,
  });

  SplashState copyWith({
    bool? loading,
    bool? isEnabled,
    bool? isReady,
    Account? account,
    Configuration? config,
    Exception? error,
  }) =>
      SplashState(
        loading: loading ?? this.loading,
        isEnabled: isEnabled ?? this.isEnabled,
        isReady: isReady ?? this.isReady,
        account: account ?? this.account,
        config: config ?? this.config,
        error: error,
      );

  @override
  List<Object?> get props => [
        loading,
        isEnabled,
        isReady,
        account,
      ];
}
