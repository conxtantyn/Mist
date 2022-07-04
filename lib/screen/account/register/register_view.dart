part of 'register.dart';

final kFormAnimationDuration = Duration(milliseconds: 100);

class _RegisterView extends StatefulWidget {
  final String phone;

  _RegisterView({Key? key, required this.phone}) : super(key: key);

  @override
  __RegisterState createState() => __RegisterState();
}

class __RegisterState
    extends BaseState<_RegisterView, RegisterBloc, RegisterState> {
  bool _canGoBack = true;

  final Map<String, String?> _firstFormFields = {};

  final Map<String, String?> _secondFormFields = {};

  final Map<String, String?> _thirdFormFields = {};

  @override
  void initState() {
    BackButtonInterceptor.add(_interceptor);
    context.read<RegisterBloc>().observer.listen(_onAction);
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration duration) {
        context.read<RegisterBloc>().add(
              InitializeEvent(Duration(
                milliseconds: kAnimationDuration.inMilliseconds ~/ 3,
              )),
            );
      },
    );
    super.initState();
  }

  void _onAction(event) {
    if (event is PageUpdate) {
      _canGoBack = event.page == 1;
    }
  }

  bool _interceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    final canGoBack = _canGoBack;

    context.read<RegisterBloc>().add(PreviousFormEvent());

    return !canGoBack;
  }

  void _onSubmit() {
    context.read<RegisterBloc>().add(OnSubmitEvent(
          widget.phone,
          {}
            ..addAll(_firstFormFields)
            ..addAll(_secondFormFields)
            ..addAll(_thirdFormFields),
        ));
  }

  @override
  void onChange(RegisterState state) {
    if (state.error != null) {
      context.showError(state.error!);
    } else if (state.isRegistered) {
      context.read<PageRouter>().navigateTo(
            Routes.login,
            clearStack: true,
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
      builder: (child) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: _ToolBar(),
              ),
            ];
          },
          body: SingleChildScrollView(child: child),
        );
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.contentPadding,
        ),
        child: Column(
          children: [
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state.animated ? 0 : 1,
                  duration: kAnimationDuration,
                  curve: Sprung.overDamped,
                  child: Container(
                    height: kLogoSmRatio.w,
                    width: kLogoSmRatio.w,
                    child: SvgPicture.asset(
                      Assets.otpSvg,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AnimatedPadding(
                  padding: EdgeInsets.only(
                    top: state.animated ? 0.0 : Dimens.padding * 2,
                  ),
                  duration: lastDuration,
                  curve: Sprung.overDamped,
                  child: Container(),
                );
              },
            ),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state.animated ? 0 : 1,
                  duration: kAnimationDuration,
                  curve: Sprung.overDamped,
                  child: Text(
                    context.text.registerLabel,
                    style: context.textTheme.headline5,
                  ),
                );
              },
            ),
            SizedBox(height: Dimens.padding * .8),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {},
              builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state.animated ? 0 : 1,
                  duration: kAnimationDuration,
                  curve: Sprung.overDamped,
                  child: AnimatedSwitcher(
                    duration: kFormAnimationDuration,
                    child: [
                      _RegistrationFirstForm(
                        formFields: _firstFormFields,
                      ),
                      _RegistrationSecondForm(
                        formFields: _secondFormFields,
                      ),
                      _RegistrationThirdForm(
                        formFields: _thirdFormFields,
                        onSubmit: _onSubmit,
                      ),
                    ].elementAt(state.page - 1),
                  ),
                );
              },
            ),
            SizedBox(height: kToolbarHeight * 2),
          ],
        ),
      ),
      footer: Padding(
        padding: EdgeInsets.only(
          top: Dimens.contentPadding,
          left: Dimens.contentPadding,
          right: Dimens.contentPadding,
          bottom: kMinInteractiveDimension * 2,
        ),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {},
          builder: (context, state) {
            return AnimatedOpacity(
              opacity: state.animated ? 0 : 1,
              duration: lastDuration,
              child: ParsedText(
                text: sprintf(context.text.registerOption, [widget.phone]),
                style: context.textTheme.overline,
                alignment: TextAlign.center,
                parse: [
                  MatchText(
                    pattern: r'' + context.text.clickHere,
                    style: context.textTheme.overline?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: (url) {
                      context.read<PageRouter>().navigateTo(
                            Routes.login,
                            clearStack: true,
                            context: context,
                            transition: TransitionType.cupertino,
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_interceptor);
    super.dispose();
  }
}

class _ToolBar extends SliverPersistentHeaderDelegate {
  void _previousForm(BuildContext context) {
    context.read<RegisterBloc>().add(PreviousFormEvent());
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: state.animated || state.page == 1 ? 0 : 1,
                duration: kAnimationDuration,
                curve: Sprung.overDamped,
                child: AppBar(
                  elevation: 0.0,
                  brightness: Brightness.dark,
                  backgroundColor: Colors.transparent,
                  iconTheme: context.theme.iconTheme.copyWith(
                    color: context.read<Skin>().colorScheme.onSurface,
                  ),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: (state.page == 1)
                            ? null
                            : () => _previousForm(context),
                        tooltip: (state.page == 1)
                            ? null
                            : MaterialLocalizations.of(context)
                                .backButtonTooltip,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent &&
        oldDelegate.maxExtent != maxExtent;
  }
}

class _RegistrationFirstForm extends StatefulWidget {
  final Map<String, String?> formFields;

  _RegistrationFirstForm({
    Key? key,
    required this.formFields,
  }) : super(key: key);

  @override
  __RegistrationFirstFormState createState() => __RegistrationFirstFormState();
}

class __RegistrationFirstFormState extends FormBlocState<_RegistrationFirstForm,
    RegisterBloc, RegisterEvent, RegisterState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  RegisterEvent formEvent(bool isValid) => UpdateFirstFormEvent(isValid);

  void _nextForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(NextFormEvent());
    }
  }

  void _onValidate(FormData data) {
    widget.formFields[data.name] = data.field.value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.contentPadding,
            ),
            child: Text(
              context.text.registerCaption,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyText1,
            ),
          ),
          SizedBox(height: Dimens.padding * 1.8),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TextFormField(
                enabled: !state.loading,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: widget.formFields[Strings.firstName],
                validator: InputValidator(
                  key: Strings.firstName,
                  value: widget.formFields[Strings.firstName],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    RequiredValidator(
                      errorText: sprintf(
                        context.text.requiredError,
                        [context.text.firstName],
                      ),
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  hintText: context.text.firstName,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TextFormField(
                enabled: !state.loading,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: widget.formFields[Strings.lastName],
                validator: InputValidator(
                  key: Strings.lastName,
                  value: widget.formFields[Strings.lastName],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    RequiredValidator(
                      errorText: sprintf(
                        context.text.requiredError,
                        [context.text.lastName],
                      ),
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  hintText: context.text.lastName,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding * 2),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PrimaryButton(
                context.text.next,
                outlined: false,
                spanWidth: true,
                showProgress: state.loading,
                onPressed: !state.isFirstFormValidated || state.loading
                    ? null
                    : () => _nextForm(context),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void close() {}
}

class _RegistrationSecondForm extends StatefulWidget {
  final Map<String, String?> formFields;

  _RegistrationSecondForm({
    Key? key,
    required this.formFields,
  }) : super(key: key);

  @override
  __RegistrationSecondFormState createState() =>
      __RegistrationSecondFormState();
}

class __RegistrationSecondFormState extends FormBlocState<
    _RegistrationSecondForm, RegisterBloc, RegisterEvent, RegisterState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  RegisterEvent formEvent(bool isValid) => UpdateSecondFormEvent(isValid);

  void _nextForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(NextFormEvent());
    }
  }

  void _onValidate(FormData data) {
    widget.formFields[data.name] = data.field.value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.contentPadding,
            ),
            child: Text(
              context.text.registerCaption,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyText1,
            ),
          ),
          SizedBox(height: Dimens.padding * 1.8),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TextFormField(
                enabled: !state.loading,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: widget.formFields[Strings.email],
                validator: InputValidator(
                  key: Strings.email,
                  value: widget.formFields[Strings.email],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    EmailValidator(
                      errorText: context.text.emailValidationErrorText,
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  hintText: context.text.email,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TextFormField(
                enabled: !state.loading,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: widget.formFields[Strings.username],
                validator: InputValidator(
                  key: Strings.username,
                  value: widget.formFields[Strings.username],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    RequiredValidator(
                      errorText: sprintf(
                        context.text.requiredError,
                        [context.text.username],
                      ),
                    ),
                    MinLengthValidator(
                      Constants.minUsernameLength,
                      errorText: context.text.usernameTooShort,
                    ),
                    PatternValidator(
                      Constants.usernamePatter,
                      errorText: context.text.usernameInvalidError,
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  hintText: context.text.username,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding * 2),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PrimaryButton(
                context.text.next,
                outlined: false,
                spanWidth: true,
                showProgress: state.loading,
                onPressed: !state.isSecondFormValidated || state.loading
                    ? null
                    : () => _nextForm(context),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void close() {}
}

class _RegistrationThirdForm extends StatefulWidget {
  final Map<String, String?> formFields;

  final VoidCallback onSubmit;

  _RegistrationThirdForm({
    Key? key,
    required this.formFields,
    required this.onSubmit,
  }) : super(key: key);

  @override
  __RegistrationThirdFormState createState() => __RegistrationThirdFormState();
}

class __RegistrationThirdFormState extends FormBlocState<_RegistrationThirdForm,
    RegisterBloc, RegisterEvent, RegisterState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  RegisterEvent formEvent(bool isValid) => UpdateThirdFormEvent(isValid);

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit();
    }
  }

  void _onValidate(FormData data) {
    widget.formFields[data.name] = data.field.value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.contentPadding,
            ),
            child: Text(
              context.text.registerCaption,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyText1,
            ),
          ),
          SizedBox(height: Dimens.padding * 1.8),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PasswordInput(
                enabled: !state.loading,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: InputValidator(
                  key: Strings.password,
                  value: widget.formFields[Strings.password],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    RequiredValidator(
                      errorText: sprintf(
                        context.text.requiredError,
                        [context.text.password],
                      ),
                    ),
                    MinLengthValidator(
                      Constants.minPasswordLength,
                      errorText: context.text.passwordLengthError,
                    ),
                    PatternValidator(
                      Constants.passwordPatter,
                      errorText: context.text.passwordCharacterError,
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  hintText: context.text.password,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PasswordInput(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: !state.loading,
                showSwitcher: false,
                validator: InputValidator(
                  key: Strings.confirmPassword,
                  value: widget.formFields[Strings.confirmPassword],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    RequiredValidator(
                      errorText: sprintf(
                        context.text.requiredError,
                        [context.text.confirmPassword],
                      ),
                    ),
                    SimpleValidator(
                      validator: (value) {
                        final pass = widget.formFields[Strings.password];
                        return pass == value &&
                            value != null &&
                            value.isNotEmpty;
                      },
                      errorText: context.text.confirmPasswordMatchError,
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  hintText: context.text.confirmPassword,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding * 2),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PrimaryButton(
                context.text.proceed,
                outlined: false,
                spanWidth: true,
                showProgress: state.loading,
                onPressed: !state.isThirdFormValidated || state.loading
                    ? null
                    : () => _onSubmit(context),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void close() {}
}
