import 'package:country_pickers/country.dart';
import 'package:equatable/equatable.dart';

class PickerState extends Equatable {
  final List<Country> countries;

  const PickerState({this.countries = const []});

  PickerState copyWith({List<Country>? countries}) => PickerState(
        countries: countries ?? this.countries,
      );

  @override
  List<Object> get props => [countries];
}
