import 'package:equatable/equatable.dart';

class RecoverState extends Equatable {
  final bool loading;

  final bool isValidated;

  final bool requestedRecovery;

  final Exception? error;

  const RecoverState({
    this.loading = false,
    this.isValidated = false,
    this.requestedRecovery = false,
    this.error,
  });

  RecoverState copyWith({
    bool? loading,
    bool? isValidated,
    bool? requestedRecovery,
    Exception? error,
  }) {
    return RecoverState(
      loading: loading ?? this.loading,
      isValidated: isValidated ?? this.isValidated,
      requestedRecovery: requestedRecovery ?? this.requestedRecovery,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        isValidated,
        requestedRecovery,
        error,
      ];
}
