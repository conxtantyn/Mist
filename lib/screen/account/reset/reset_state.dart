import 'package:equatable/equatable.dart';

class ResetState extends Equatable {
  final bool loading;

  final bool isPinValid;

  final bool isFormValid;

  final bool isResetSuccessful;

  final String? code;

  final Exception? error;

  const ResetState({
    this.loading = false,
    this.isPinValid = false,
    this.isFormValid = false,
    this.isResetSuccessful = false,
    this.code,
    this.error,
  });

  ResetState copyWith({
    bool? loading,
    bool? isPinValid,
    bool? isFormValid,
    bool? isResetSuccessful,
    String? code,
    Exception? error,
  }) {
    return ResetState(
      loading: loading ?? this.loading,
      isPinValid: isPinValid ?? this.isPinValid,
      isFormValid: isFormValid ?? this.isFormValid,
      isResetSuccessful: isResetSuccessful ?? this.isResetSuccessful,
      code: code ?? this.code,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        isPinValid,
        isFormValid,
        isResetSuccessful,
        code,
        error,
      ];
}
