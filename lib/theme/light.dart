import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../common/common.dart';

import 'component/component.dart';

class _LightScheme extends Skin {
  _LightScheme()
      : super(
          colorScheme: ColorScheme(
            primary: const Color(0xff0678B8),
            primaryVariant: const Color(0xff172239),
            secondary: const Color(0xffF5F6FA),
            secondaryVariant: const Color(0xffE5E9F2),
            surface: const Color(0xffF9FAFC),
            background: Colors.white,
            error: const Color(0xffEB5757),
            onPrimary: const Color(0xffFEFFFF),
            onSecondary: const Color(0xffA7ADB2),
            onSurface: const Color(0xff111111),
            onBackground: const Color(0xff5A646A),
            onError: Colors.white,
            brightness: Brightness.light,
          ),
          border: const Color(0xffE5E5E5),
          background: const Color(0xffEFF2F7),
          muted: const Color(0xff92999D),
          info: const Color(0xffA97F00),
          disabled: const Color(0xffE5E6E8),
          success: const Color(0xff27AE60),
          warning: const Color(0xffF2C94C),
          onInfo: Colors.white,
          onDisabled: const Color(0xffA7ADB2),
          onSuccess: Colors.white,
          onWarning: const Color(0xffA97F00),
        );
}

final _kSkin = _LightScheme();

final _kTextTheme = KTextTheme(_kSkin.colorScheme);

class LightTheme extends AppTheme {
  LightTheme(BuildContext context)
      : super(
          id: 'light',
          description: '',
          options: _kSkin,
          data: ThemeData.from(
            colorScheme: _kSkin.colorScheme,
            textTheme: _kTextTheme,
          ).copyWith(
            inputDecorationTheme: KInputTheme(context, _kSkin, _kTextTheme),
            buttonTheme: KButtonTheme(_kSkin),
          ),
        );
}
