import 'package:flutter/material.dart';

import '../../common/common.dart';

class KButtonTheme extends ButtonThemeData {
  KButtonTheme(Skin skin)
      : super(
          colorScheme: skin.colorScheme,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.buttonRadius),
            ),
          ),
          buttonColor: skin.colorScheme.primary,
          disabledColor: skin.disabled,
          focusColor: skin.colorScheme.primaryVariant,
          hoverColor: skin.colorScheme.primaryVariant,
          splashColor: skin.colorScheme.primaryVariant,
        );
}
