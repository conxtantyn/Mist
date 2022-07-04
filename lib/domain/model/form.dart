import 'package:equatable/equatable.dart';

class EditField extends Equatable {
  final bool isValid;

  final String? value;

  const EditField(this.isValid, this.value);

  @override
  List<Object?> get props => [isValid, value];
}
