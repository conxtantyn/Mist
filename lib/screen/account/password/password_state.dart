import 'package:equatable/equatable.dart';

class PasswordState extends Equatable {
  final bool loading;

  final bool isValidated;

  final bool isAuthenticated;

  final dynamic error;

  const PasswordState({
    this.loading = false,
    this.isValidated = false,
    this.isAuthenticated = false,
    this.error,
  });

  PasswordState copyWith({
    bool? loading,
    bool? isValidated,
    bool? isAuthenticated,
    dynamic error,
  }) {
    return PasswordState(
      loading: loading ?? this.loading,
      isValidated: isValidated ?? this.isValidated,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        isValidated,
        isAuthenticated,
        error,
      ];
}
