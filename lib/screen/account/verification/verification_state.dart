import 'package:equatable/equatable.dart';

class VerificationState extends Equatable {
  final bool loading;

  final bool resendingOtp;

  final bool validated;

  final bool isUnVerifiable;

  final String otp;

  final String? phone;

  final int? duration;

  final Exception? error;

  const VerificationState({
    this.loading = false,
    this.resendingOtp = false,
    this.validated = false,
    this.isUnVerifiable = false,
    this.error,
    this.otp = '',
    this.phone,
    this.duration,
  });

  VerificationState copyWith({
    bool? loading,
    bool? resendingOtp,
    bool? validated,
    bool? isUnVerifiable = false,
    Exception? error,
    String? otp,
    String? phone,
    int? duration,
  }) =>
      VerificationState(
        loading: loading ?? this.loading,
        resendingOtp: resendingOtp ?? this.resendingOtp,
        validated: validated ?? this.validated,
        isUnVerifiable: isUnVerifiable ?? this.isUnVerifiable,
        error: error,
        otp: otp ?? this.otp,
        phone: phone ?? this.phone,
        duration: duration ?? this.duration,
      );

  @override
  List<Object?> get props => [
        loading,
        resendingOtp,
        validated,
        otp,
        isUnVerifiable,
        phone,
        duration,
      ];
}
