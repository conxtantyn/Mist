import 'package:country_pickers/country.dart';
import 'package:equatable/equatable.dart';

abstract class PickerEvent extends Equatable {
  const PickerEvent();

  @override
  List<Object> get props => [];
}

class UpdateCountryEvent extends PickerEvent {
  final List<Country> countries;

  UpdateCountryEvent(this.countries);

  @override
  List<Object> get props => [countries];
}

class SearchEvent extends PickerEvent {
  final String search;

  SearchEvent(this.search);

  @override
  List<Object> get props => [search];
}
