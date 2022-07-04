import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common/common.dart';

extension ScalePadding on BuildContext {
  EdgeInsetsGeometry scaledPadding(
    EdgeInsetsGeometry geometry1x,
    EdgeInsetsGeometry geometry2x,
    EdgeInsetsGeometry geometry3x,
  ) {
    final textScaleFactor = MediaQuery.maybeOf(this)?.textScaleFactor ?? 1;
    if (textScaleFactor <= 1) {
      return geometry1x;
    } else if (textScaleFactor >= 3) {
      return geometry3x;
    } else if (textScaleFactor <= 2) {
      return EdgeInsetsGeometry.lerp(
          geometry1x, geometry2x, textScaleFactor - 1)!;
    }
    return EdgeInsetsGeometry.lerp(
        geometry2x, geometry3x, textScaleFactor - 2)!;
  }
}

extension ApplicationThemeData on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  Skin get skin => read<Skin>();
}

extension ApplicationString on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}
