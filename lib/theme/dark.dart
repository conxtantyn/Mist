import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../common/common.dart';

import 'component/component.dart';

class _DarkScheme extends Skin {
  _DarkScheme()
      : super(
          colorScheme: ColorScheme.dark(),
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

final _kSkin = _DarkScheme();

final _kTextTheme = KTextTheme(_kSkin.colorScheme);

class DarkTheme extends AppTheme {
  DarkTheme(BuildContext context)
      : super(
          id: 'dark',
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
