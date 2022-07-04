import 'package:country_pickers/country_pickers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../common/common.dart';
import '../repository/repository.dart';
import '../util/util.dart';

const kPinAnimationDuration = Duration(milliseconds: 200);

class PhoneInput extends StatefulWidget {
  final bool autoFocus;

  final bool obscureText;

  final bool enabled;

  final String countryCode;

  final int? maxLength;

  final FocusNode? focusNode;

  final TextAlign textAlign;

  final TextCapitalization textCapitalization;

  final InputDecoration decoration;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  PhoneInput({
    Key? key,
    this.autoFocus = false,
    this.obscureText = false,
    this.enabled = true,
    required this.countryCode,
    this.maxLength,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.sentences,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  final mask = MaskTextInputFormatter(mask: "(###) ###-##-###");
  final controller = TextEditingController();

  String? countryCode;

  BorderRadius? _getRadius(BuildContext context) {
    if (Theme.of(context).inputDecorationTheme.border is OutlineInputBorder) {
      final radius =
          (Theme.of(context).inputDecorationTheme.border as OutlineInputBorder)
              .borderRadius;
      return radius.copyWith(
        topLeft: radius.topLeft / 2,
        topRight: radius.topRight / 2,
        bottomLeft: radius.bottomLeft / 2,
        bottomRight: radius.bottomRight / 2,
      );
    }
    return null;
  }

  void _reset() {
    if (countryCode != widget.countryCode) {
      controller.text = '';
      if (widget.onChanged != null) widget.onChanged!('');
    }
    countryCode = widget.countryCode;
  }

  @override
  Widget build(BuildContext context) {
    final country = CountryPickerUtils.getCountryByIsoCode(widget.countryCode);
    final padding = context.scaledPadding(
      const EdgeInsets.symmetric(
        vertical: Dimens.inputFlagVerticalPadding / 2,
        horizontal: Dimens.inputHorizontalPadding / 2,
      ),
      const EdgeInsets.symmetric(
        vertical: Dimens.inputFlagVerticalPadding / 4,
        horizontal: Dimens.inputHorizontalPadding / 4,
      ),
      const EdgeInsets.symmetric(
        vertical: Dimens.inputFlagVerticalPadding / 8,
        horizontal: Dimens.inputHorizontalPadding / 8,
      ),
    );
    final contentPadding = context.scaledPadding(
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding,
        left: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 2),
        right: Dimens.inputHorizontalPadding,
        bottom: Dimens.inputVerticalPadding,
      ),
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding / 2,
        left: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 4),
        right: Dimens.inputHorizontalPadding / 2,
        bottom: Dimens.inputVerticalPadding / 2,
      ),
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding / 4,
        left: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 8),
        right: Dimens.inputHorizontalPadding / 4,
        bottom: Dimens.inputVerticalPadding / 4,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration duration) => _reset(),
    );
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        TextFormField(
          enabled: widget.enabled,
          autofocus: widget.autoFocus,
          obscureText: widget.obscureText,
          maxLength: widget.maxLength,
          textAlign: widget.textAlign,
          focusNode: widget.focusNode,
          keyboardType: TextInputType.phone,
          textCapitalization: widget.textCapitalization,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: [mask],
          controller: controller,
          decoration: widget.decoration.copyWith(
            contentPadding: contentPadding,
          ),
        ),
        Container(
          width: kMinInteractiveDimension - (padding.horizontal / 2),
          height: contentPadding.vertical / 1.2,
          margin: padding,
          child: PhysicalModel(
            clipBehavior: Clip.antiAlias,
            color: Theme.of(context).backgroundColor,
            borderRadius: _getRadius(context),
            child: InkWell(
              onTap: () {
                context.read<PageRouter>().navigateTo(
                      Routes.countryPicker,
                      context: context,
                      transition: TransitionType.cupertinoFullScreenDialog,
                    );
              },
              child: Image.asset(
                CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
                package: 'country_pickers',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordInput extends StatefulWidget {
  final bool autoFocus;

  final bool enabled;

  final bool showSwitcher;

  final int? maxLength;

  final FocusNode? focusNode;

  final TextAlign textAlign;

  final TextCapitalization textCapitalization;

  final AutovalidateMode? autovalidateMode;

  final InputDecoration decoration;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final FormFieldValidator<String>? validator;

  PasswordInput({
    Key? key,
    this.autoFocus = false,
    this.enabled = true,
    this.showSwitcher = true,
    this.maxLength,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.sentences,
    this.autovalidateMode,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.onSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscureText = true;

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

  @override
  Widget build(BuildContext context) {
    final padding = context.scaledPadding(
      const EdgeInsets.symmetric(
        horizontal: Dimens.inputHorizontalPadding / 2,
      ),
      const EdgeInsets.symmetric(
        horizontal: Dimens.inputHorizontalPadding / 4,
      ),
      const EdgeInsets.symmetric(
        horizontal: Dimens.inputHorizontalPadding / 8,
      ),
    );
    final contentPadding = context.scaledPadding(
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding,
        left: Dimens.inputHorizontalPadding,
        right: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 4),
        bottom: Dimens.inputVerticalPadding,
      ),
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding / 2,
        left: Dimens.inputHorizontalPadding / 2,
        right: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 8),
        bottom: Dimens.inputVerticalPadding / 2,
      ),
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding / 4,
        left: Dimens.inputHorizontalPadding / 4,
        right: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 16),
        bottom: Dimens.inputVerticalPadding / 4,
      ),
    );
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        TextFormField(
          enabled: widget.enabled,
          autofocus: widget.autoFocus,
          obscureText: obscureText,
          maxLength: widget.maxLength,
          textAlign: widget.textAlign,
          focusNode: widget.focusNode,
          keyboardType: TextInputType.visiblePassword,
          textCapitalization: widget.textCapitalization,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          autovalidateMode: widget.autovalidateMode,
          validator: widget.validator,
          decoration: widget.decoration.copyWith(
            contentPadding: contentPadding,
            errorBorder: _inputBorder(
              context.skin.colorScheme.secondaryVariant,
            ),
            focusedErrorBorder: _inputBorder(
              context.skin.colorScheme.secondaryVariant,
            ),
          ),
        ),
        if (widget.showSwitcher) ...[
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => setState(() => obscureText = !obscureText),
              child: Container(
                width: contentPadding.vertical,
                padding: EdgeInsets.symmetric(
                  vertical: contentPadding.vertical / 2,
                ),
                margin: padding,
                child: Center(
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    size: context.textTheme.headline5?.fontSize,
                    color: obscureText
                        ? context.read<Skin>().colorScheme.onSecondary
                        : context
                            .read<Skin>()
                            .colorScheme
                            .onSecondary
                            .withOpacity(
                              .6,
                            ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class SearchInput extends StatelessWidget {
  final bool autoFocus;

  final bool obscureText;

  final bool enabled;

  final int? maxLength;

  final FocusNode? focusNode;

  final TextAlign textAlign;

  final TextInputType keyboardType;

  final TextCapitalization textCapitalization;

  final InputDecoration decoration;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  SearchInput({
    Key? key,
    this.autoFocus = false,
    this.obscureText = false,
    this.enabled = true,
    this.maxLength,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide.none,
    );
    final padding = context.scaledPadding(
      const EdgeInsets.symmetric(
        horizontal: Dimens.inputHorizontalPadding / 2,
      ),
      const EdgeInsets.symmetric(
        horizontal: Dimens.inputHorizontalPadding / 4,
      ),
      const EdgeInsets.symmetric(
        horizontal: Dimens.inputHorizontalPadding / 8,
      ),
    );
    final contentPadding = context.scaledPadding(
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding,
        left: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 4),
        right: Dimens.inputHorizontalPadding,
        bottom: Dimens.inputVerticalPadding,
      ),
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding / 2,
        left: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 8),
        right: Dimens.inputHorizontalPadding / 2,
        bottom: Dimens.inputVerticalPadding / 2,
      ),
      const EdgeInsets.only(
        top: Dimens.inputVerticalPadding / 4,
        left: kMinInteractiveDimension + (Dimens.inputHorizontalPadding / 16),
        right: Dimens.inputHorizontalPadding / 4,
        bottom: Dimens.inputVerticalPadding / 4,
      ),
    );
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        TextFormField(
          enabled: enabled,
          autofocus: autoFocus,
          obscureText: obscureText,
          maxLength: maxLength,
          textAlign: textAlign,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          decoration: decoration.copyWith(
            contentPadding: contentPadding,
            border: border,
            enabledBorder: border,
            disabledBorder: border,
            errorBorder: border,
            focusedBorder: border,
            focusedErrorBorder: border,
          ),
        ),
        Container(
          width: contentPadding.vertical,
          height: contentPadding.vertical,
          margin: padding,
          child: Center(
            child: Icon(
              Icons.search,
              size: contentPadding.vertical / 1.5,
              color: context.read<Skin>().colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class PinInput extends StatefulWidget {
  final bool enabled;
  final bool autoDismissKeyboard;
  final Function(String) onChanged;
  final Function(String) onCompleted;

  PinInput({
    Key? key,
    this.enabled = true,
    this.autoDismissKeyboard = true,
    required this.onChanged,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _PinInputState createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = (width - (Dimens.contentPadding * 4)) / 6;
    return PinCodeTextField(
      length: Constants.kOtpLength,
      appContext: context,
      obscureText: false,
      autoFocus: true,
      autoDismissKeyboard: widget.autoDismissKeyboard,
      enableActiveFill: true,
      enabled: widget.enabled,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      textStyle: Theme.of(context).textTheme.headline4?.copyWith(
            color: context.read<Skin>().colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderWidth: 1.0,
        borderRadius: BorderRadius.all(Radius.elliptical(
          Dimens.inputRadius,
          Dimens.inputRadius,
        )),
        fieldHeight: size,
        fieldWidth: size,
        selectedColor: context.read<Skin>().colorScheme.secondaryVariant,
        selectedFillColor: context.read<Skin>().colorScheme.surface,
        inactiveColor: context.read<Skin>().colorScheme.secondary,
        inactiveFillColor: context.read<Skin>().colorScheme.surface,
        activeColor: context.read<Skin>().colorScheme.secondaryVariant,
        activeFillColor: context.read<Skin>().colorScheme.surface,
        disabledColor: context.read<Skin>().colorScheme.surface,
      ),
      animationDuration: kPinAnimationDuration,
      backgroundColor: Colors.transparent,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      beforeTextPaste: (text) => false,
    );
  }
}
