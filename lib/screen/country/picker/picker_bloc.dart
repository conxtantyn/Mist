import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'picker_event.dart';
import 'picker_state.dart';

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  PickerBloc() : super(const PickerState());

  @override
  Stream<PickerState> mapEventToState(PickerEvent event) async* {
    if (event is UpdateCountryEvent) {
      yield state.copyWith(
        countries: event.countries,
      );
    } else if (event is SearchEvent) {
      final search = event.search.toLowerCase();
      yield state.copyWith(
          countries: countryList
              .where((Country country) =>
                  country.name.toLowerCase().startsWith(search) ||
                  country.phoneCode.startsWith(search) ||
                  country.isoCode.toLowerCase().startsWith(search))
              .toList());
    }
  }
}
