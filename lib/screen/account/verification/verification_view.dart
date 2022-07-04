part of 'verification.dart';

class _VerificationView extends StatefulWidget {
  @override
  __VerificationViewState createState() => __VerificationViewState();
}

class __VerificationViewState
    extends BaseState<_VerificationView, VerificationBloc, VerificationState> {
  @override
  void initState() {
    context.read<MainBloc>().observer.listen(_onMainAction).include(steams);
    context.read<VerificationBloc>().observer.listen(_onAction);
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration duration) => context.read<VerificationBloc>().add(
            InitializeEvent(),
          ),
    );
    super.initState();
  }

  void _onMainAction(MainAction? action) {
    context.read<PageRouter>().navigate(context, action);
  }

  void _onAction(VerificationAction? action) {
    if (action is VerifiedAction) {
      context.read<MainBloc>().add(
            UpdateAccountEvent(action.account),
          );
    }
  }

  @override
  void onChange(VerificationState state) {
    if (state.isUnVerifiable) {
      context.showErrorWithRetryOption(state.error!, () {
        Navigator.of(context).pop();
      });
    } else if (state.error != null) {
      context.showError(state.error!);
    }
    super.onChange(state);
  }

  void _toPassword(url) {
    context.read<PageRouter>().navigateTo(
          Routes.password,
          context: context,
          transition: TransitionType.cupertino,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      alignment: Alignment.center,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.contentPadding,
        ),
        child: Column(
          children: [
            SizedBox(height: Dimens.padding * 2),
            Container(
              height: kLogoSmRatio.w,
              width: kLogoSmRatio.w,
              child: SvgPicture.asset(
                Assets.otpSvg,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: kMinInteractiveDimension),
            Text(
              context.text.otpLabel,
              style: context.textTheme.headline5,
            ),
            SizedBox(height: Dimens.padding * .8),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.contentPadding,
              ),
              child: Text(
                context.text.otpCaption,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyText1,
              ),
            ),
            _VerificationForm(),
            SizedBox(height: Dimens.padding),
            _ResendOption(),
            SizedBox(height: Dimens.contentPadding),
          ],
        ),
      ),
      footer: Padding(
        padding: EdgeInsets.only(
          top: Dimens.contentPadding,
          left: Dimens.contentPadding,
          right: Dimens.contentPadding,
          bottom: kMinInteractiveDimension,
        ),
        child: ParsedText(
          text: context.text.passwordLoginOption,
          style: context.textTheme.overline,
          parse: [
            MatchText(
              pattern: r'' + context.text.password.toLowerCase(),
              style: context.textTheme.overline?.copyWith(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              onTap: _toPassword,
            ),
          ],
        ),
      ),
    );
  }
}

class _VerificationForm extends StatelessWidget {
  const _VerificationForm({Key? key}) : super(key: key);

  void _verifyOtp(BuildContext context, VerificationState state) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    context.read<VerificationBloc>().add(
          VerifyOtpEvent(state.otp),
        );
  }

  void _validateOtp(BuildContext context, String otp) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    context.read<VerificationBloc>().add(ValidateOtpEvent(otp));
  }

  @override
  Widget build(BuildContext context) {
    final string = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(height: Dimens.padding * 1.8),
        BlocConsumer<VerificationBloc, VerificationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return PinInput(
              enabled: !state.resendingOtp && !state.loading,
              onCompleted: (pin) {},
              onChanged: (pin) => _validateOtp(context, pin),
            );
          },
        ),
        SizedBox(height: Dimens.contentPadding),
        BlocConsumer<VerificationBloc, VerificationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return PrimaryButton(
              string.otpButtonLabel,
              outlined: false,
              spanWidth: true,
              showProgress: state.loading,
              onPressed: _onPressed(context, state),
            );
          },
        ),
      ],
    );
  }

  dynamic _onPressed(BuildContext context, VerificationState state) {
    return state.validated && !state.loading && !state.resendingOtp
        ? () => _verifyOtp(context, state)
        : null;
  }
}

class _ResendOption extends StatelessWidget {
  const _ResendOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationBloc, VerificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: kAnimationDuration,
          child: (state.duration == null)
              ? Container()
              : !state.resendingOtp
                  ? _ResendTextLabel(
                      text: context.text.otpResendLabel,
                      inActiveText: context.text.otpInactiveLabel,
                      phone: state.phone!,
                      seconds: state.duration!,
                    )
                  : Text(
                      context.text.resendingOtpLabel,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyText1,
                    ),
        );
      },
    );
  }
}

class _ResendTextLabel extends StatefulWidget {
  final String text;
  final String inActiveText;
  final String phone;
  final int seconds;

  const _ResendTextLabel({
    Key? key,
    required this.text,
    required this.inActiveText,
    required this.phone,
    required this.seconds,
  }) : super(key: key);

  @override
  __ResendTextLabelState createState() => __ResendTextLabelState();
}

class __ResendTextLabelState extends State<_ResendTextLabel> {
  Timer? _timer;

  ValueNotifier<String>? _notifier;

  @override
  void initState() {
    _notifier = ValueNotifier(_evaluate(0));
    _timer = Timer.periodic(Duration(seconds: 1), _updateView);

    super.initState();
  }

  void _updateView(Timer t) {
    _notifier?.value = _evaluate(t.tick);
  }

  String _evaluate(int seconds) {
    final diff = widget.seconds - seconds;
    if (diff < 1) {
      _timer?.cancel();
      return widget.text;
    }
    return sprintf(widget.inActiveText, [diff]);
  }

  void _onResendOtp(MainState state) {
    context.read<VerificationBloc>().add(
          ReAuthenticateEvent(
            widget.phone,
            state.configuration!.locale.languageCode,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {},
      builder: (_, mainState) {
        return ValueListenableBuilder<String>(
          valueListenable: _notifier!,
          builder: (_, String value, Widget? child) {
            return _ResentText(
              text: value,
              enabled: _timer!.isActive,
              onTap: () => _onResendOtp(mainState),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _notifier?.dispose();
    _timer?.cancel();

    super.dispose();
  }
}

class _ResentText extends StatelessWidget {
  final String text;

  final bool enabled;

  final VoidCallback onTap;

  const _ResentText({
    Key? key,
    required this.text,
    required this.enabled,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kAnimationDuration,
      child: (enabled)
          ? Text(
              text,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyText1,
            )
          : ParsedText(
              text: context.text.otpResendLabel,
              style: context.textTheme.overline,
              parse: [
                MatchText(
                  pattern: r'' + context.text.otpResendLabel,
                  style: context.textTheme.bodyText1?.copyWith(
                    color: context.theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: (_) => onTap(),
                ),
              ],
            ),
    );
  }
}
