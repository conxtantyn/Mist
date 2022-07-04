import 'package:equatable/equatable.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../common/common.dart';
import '../domain/domain.dart';

class FormData extends Equatable {
  final String name;
  final EditField field;

  FormData(this.name, this.field);

  @override
  List<Object?> get props => [this.name, this.field];
}

class InputValidator extends MultiValidator {
  final String key;
  final String? value;
  final StateNotifier<FormData?> notifier;
  final Function(FormData)? onValidate;

  InputValidator({
    required this.key,
    required this.value,
    required this.notifier,
    this.onValidate,
    required List<FieldValidator> validators,
  }) : super(validators) {
    if (value == null) {
      notifier.update(FormData(key, EditField(false, null)));
    }
  }

  @override
  String? call(value) {
    final result = super.call(value);
    final field = EditField(result == null, value);
    final data = FormData(key, field);

    notifier.update(data);
    if (onValidate != null) onValidate!(data);

    return result;
  }
}

class SimpleValidator extends TextFieldValidator {
  final bool Function(String?) validator;

  SimpleValidator({
    required this.validator,
    required String errorText,
  }) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => validator(value);

  @override
  String? call(String? value) {
    return isValid(value) ? null : errorText;
  }
}
