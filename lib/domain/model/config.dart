import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../model/model.dart';

class Configuration extends Equatable {
  final Locale locale;

  final DeviceLocation location;

  Configuration(this.locale, this.location);

  Configuration copyWith({Locale? locale, DeviceLocation? location}) =>
      Configuration(
        locale ?? this.locale,
        location ?? this.location,
      );

  @override
  List<Object> get props => [locale, location];
}
