import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../util/util.dart';

import 'text.dart';

OutlineInputBorder _inputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(Dimens.inputRadius),
    ),
    borderSide: BorderSide(
      color: color,
      width: 1.0,
    ),
  );
}

class KInputTheme extends InputDecorationTheme {
  KInputTheme(BuildContext context, Skin skin, KTextTheme textTheme)
      : super(
          filled: true,
          isDense: true,
          hintStyle: textTheme.bodyText1?.copyWith(
            color: skin.colorScheme.onSecondary,
            fontWeight: FontWeight.w300,
          ),
          errorStyle: textTheme.overline?.copyWith(
            color: skin.colorScheme.error,
          ),
          fillColor: skin.colorScheme.surface,
          focusColor: skin.colorScheme.surface,
          hoverColor: skin.colorScheme.surface,
          border: _inputBorder(skin.colorScheme.secondaryVariant),
          focusedBorder: _inputBorder(skin.colorScheme.secondaryVariant),
          disabledBorder: _inputBorder(
            skin.colorScheme.secondaryVariant.withOpacity(.4),
          ),
          enabledBorder: _inputBorder(
            skin.colorScheme.secondaryVariant.withOpacity(.6),
          ),
          errorBorder: _inputBorder(skin.colorScheme.error.withOpacity(.4)),
          focusedErrorBorder: _inputBorder(
            skin.colorScheme.error.withOpacity(.8),
          ),
          contentPadding: context.scaledPadding(
            const EdgeInsets.symmetric(
              vertical: Dimens.inputVerticalPadding,
              horizontal: Dimens.inputHorizontalPadding,
            ),
            const EdgeInsets.symmetric(
              vertical: Dimens.inputVerticalPadding / 2,
              horizontal: Dimens.inputHorizontalPadding / 2,
            ),
            const EdgeInsets.symmetric(
              vertical: Dimens.inputVerticalPadding / 4,
              horizontal: Dimens.inputHorizontalPadding / 4,
            ),
          ),
        );
}
