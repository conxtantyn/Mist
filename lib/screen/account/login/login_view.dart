part of 'login.dart';

class _LoginView extends StatefulWidget {
  _LoginView({Key? key}) : super(key: key);

  @override
  __LoginViewState createState() => __LoginViewState();
}

class __LoginViewState extends BaseState<_LoginView, LoginBloc, LoginState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration duration) {
        context.read<LoginBloc>().add(
              InitializeEvent(Duration(
                milliseconds: kAnimationDuration.inMilliseconds ~/ 3,
              )),
            );
      },
    );
    super.initState();
  }

  @override
  void onChange(LoginState state) {
    if (state.error != null) {
      context.showError(state.error!);
    } else if (state.finished) {
      context.read<PageRouter>().navigateTo(
            Routes.verification,
            context: context,
            transition: TransitionType.cupertino,
          );
    }
    super.onChange(state);
  }

  @override
  Widget build(BuildContext context) {
    final lastDuration = Duration(
      milliseconds: kAnimationDuration.inMilliseconds * 4,
    );
    return Section(
      alignment: Alignment.center,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.contentPadding,
        ),
        child: Column(
          children: [
            SizedBox(height: Dimens.padding),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state.animated ? 0 : 1,
                  duration: kAnimationDuration,
                  curve: Sprung.overDamped,
                  child: LogoBox.sm(),
                );
              },
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AnimatedPadding(
                  padding: EdgeInsets.only(
                    top: state.animated ? 0.0 : kMinInteractiveDimension,
                  ),
                  duration: kAnimationDuration,
                  curve: Sprung.overDamped,
                  child: Container(),
                );
              },
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state.animated ? 0 : 1,
                  duration: lastDuration,
                  curve: Sprung.overDamped,
                  child: Text(
                    context.text.loginCaption,
                    style: context.textTheme.headline5,
                  ),
                );
              },
            ),
            SizedBox(height: Dimens.padding * 2),
            _LoginForm(),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _LoginForm({Key? key}) : super(key: key);

  void _validatePhone(BuildContext context, Locale locale, String phone) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    context.read<LoginBloc>().add(ValidatePhoneEvent(locale, phone));
  }

  void _authenticate(BuildContext context, Locale locale, LoginState state) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    context.read<LoginBloc>().add(AuthenticateEvent(
          state.phone!,
          locale.languageCode,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final lastDuration = Duration(
      milliseconds: kAnimationDuration.inMilliseconds * 4,
    );
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {},
            builder: (context, state) {
              return BlocConsumer<MainBloc, MainState>(
                listener: (context, mainState) {
                  final locale = mainState.configuration!.locale;
                  _validatePhone(context, locale, state.phone ?? '');
                },
                builder: (_, mainState) {
                  final locale = mainState.configuration!.locale;
                  return AnimatedOpacity(
                    opacity: state.animated ? 0 : 1,
                    duration: lastDuration,
                    curve: Sprung.overDamped,
                    child: PhoneInput(
                      onChanged: (phone) {
                        _validatePhone(context, locale, phone);
                      },
                      enabled: !state.loading,
                      countryCode: locale.countryCode!,
                      decoration: InputDecoration(
                        hintText: Strings.phonePlaceholder,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: Dimens.padding * .8),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {},
            builder: (context, state) {
              return AnimatedOpacity(
                opacity: state.animated ? 0 : 1,
                duration: lastDuration,
                curve: Sprung.overDamped,
                child: Text(
                  context.text.loginPhoneCaption,
                  textAlign: TextAlign.center,
                  style: style.bodyText1,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding * 2),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {},
            builder: (context, state) {
              return BlocConsumer<MainBloc, MainState>(
                listener: (context, state) {},
                builder: (_, mainState) {
                  final locale = mainState.configuration!.locale;
                  return AnimatedOpacity(
                    opacity: state.animated ? 0 : 1,
                    duration: lastDuration,
                    curve: Sprung.overDamped,
                    child: PrimaryButton(
                      context.text.loginLabel,
                      outlined: false,
                      spanWidth: true,
                      showProgress: state.loading,
                      onPressed: _onPressed(context, locale, state),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: kToolbarHeight),
        ],
      ),
    );
  }

  dynamic _onPressed(BuildContext context, Locale locale, LoginState state) {
    return (!state.enabled || state.loading)
        ? null
        : () => _authenticate(context, locale, state);
  }
}
