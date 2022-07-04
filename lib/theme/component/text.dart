import 'package:flutter/material.dart';

import '../../common/common.dart';

const String kBodyFontFamily = Constants.defaultFont;
const String kHeaderFontFamily = Constants.defaultFont;

const double _kHeadLine1 = 40;
const double _kHeadLine2 = 32;
const double _kHeadLine3 = 28;
const double _kHeadLine4 = 22;
const double _kHeadLine5 = 20;
const double _kHeadLine6 = 18;

const double _kSubtitle1 = 16;
const double _kSubtitle2 = 14;

const double _kBodyText1 = 14.0;
const double _kBodyText2 = 12.0;

const double _kCaption = 12.0;
const double _kButton = 16;
const double _kOverline = 12.0;

TextStyle _fromBodyFont(Color color, double fontSize, [double? height]) {
  return TextStyle(fontFamily: kBodyFontFamily).copyWith(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w300,
    height: height,
  );
}

TextStyle _fromBodyBoldFont(Color color, double fontSize) {
  return _fromBodyFont(color, fontSize).copyWith(
    fontWeight: FontWeight.w600,
  );
}

TextStyle _fromHeaderFont(Color color, double fontSize) {
  return TextStyle(fontFamily: kHeaderFontFamily).copyWith(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w600,
  );
}

class KTextTheme extends TextTheme {
  KTextTheme(ColorScheme scheme)
      : super(
          headline1: _fromHeaderFont(scheme.onSurface, _kHeadLine1),
          headline2: _fromHeaderFont(scheme.onSurface, _kHeadLine2),
          headline3: _fromHeaderFont(scheme.onSurface, _kHeadLine3),
          headline4: _fromHeaderFont(scheme.onSurface, _kHeadLine4),
          headline5: _fromHeaderFont(scheme.onSurface, _kHeadLine5),
          headline6: _fromHeaderFont(scheme.onSurface, _kHeadLine6),
          subtitle1: _fromBodyBoldFont(scheme.onSurface, _kSubtitle1),
          subtitle2: _fromBodyFont(scheme.onBackground, _kSubtitle2),
          bodyText1: _fromBodyFont(scheme.onBackground, _kBodyText1, 1.5),
          bodyText2: _fromBodyFont(scheme.onBackground, _kBodyText2, 1.5),
          caption: _fromBodyFont(scheme.onSecondary, _kCaption),
          button: _fromBodyBoldFont(scheme.onPrimary, _kButton),
          overline: _fromBodyFont(scheme.onSurface, _kOverline),
        );
}
