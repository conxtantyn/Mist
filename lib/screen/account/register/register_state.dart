import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool loading;

  final bool animated;

  final bool isFirstFormValidated;

  final bool isSecondFormValidated;

  final bool isThirdFormValidated;

  final bool isRegistered;

  final int page;

  final String? phone;

  final Exception? error;

  const RegisterState({
    this.loading = false,
    required this.animated,
    this.isFirstFormValidated = false,
    this.isSecondFormValidated = false,
    this.isThirdFormValidated = false,
    this.isRegistered = false,
    this.page = 1,
    this.phone,
    this.error,
  });

  RegisterState copyWith({
    bool? loading,
    bool? animated,
    bool? isFirstFormValidated,
    bool? isSecondFormValidated,
    bool? isThirdFormValidated,
    bool? isRegistered,
    int? page,
    String? phone,
    Exception? error,
  }) =>
      RegisterState(
        loading: loading ?? this.loading,
        animated: animated ?? this.animated,
        isFirstFormValidated: isFirstFormValidated ?? this.isFirstFormValidated,
        isSecondFormValidated:
            isSecondFormValidated ?? this.isSecondFormValidated,
        isThirdFormValidated: isThirdFormValidated ?? this.isThirdFormValidated,
        isRegistered: isRegistered ?? this.isRegistered,
        page: page ?? this.page,
        phone: phone ?? this.phone,
        error: error,
      );

  @override
  List<Object?> get props => [
        loading,
        animated,
        isFirstFormValidated,
        isSecondFormValidated,
        isThirdFormValidated,
        isRegistered,
        page,
        phone,
      ];
}
