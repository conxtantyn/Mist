import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class OnInitializeEvent extends SplashEvent {
  final Locale locale;

  final Duration delay;

  OnInitializeEvent(this.locale, this.delay);

  @override
  List<Object> get props => [locale, delay];
}
