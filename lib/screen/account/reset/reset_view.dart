part of 'reset.dart';

class _ResetView extends StatefulWidget {
  @override
  __ResetViewState createState() => __ResetViewState();
}

class __ResetViewState
    extends FormBlocState<_ResetView, ResetBloc, ResetEvent, ResetState> {
  @override
  ResetEvent formEvent(bool isValid) => UpdateFormEvent(isValid);

  @override
  void onChange(ResetState state) {
    if (state.error != null) {
      context.showError(state.error!);
    } else if (state.isResetSuccessful) {
      context.read<PageRouter>().navigateTo(
            Routes.login,
            context: context,
            clearStack: true,
            transition: TransitionType.cupertino,
          );
    }
    super.onChange(state);
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      alignment: Alignment.topCenter,
      overflow: -(kToolbarHeight * 2),
      builder: (child) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: SliverToolBar(
                  title: context.text.passwordLabel,
                ),
              ),
            ];
          },
          body: SingleChildScrollView(child: child),
        );
      },
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.contentPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Dimens.padding * .5),
            SizedBox(
              width: double.infinity,
              child: Text(
                context.text.resetPasswordCaption,
                style: context.textTheme.bodyText1,
              ),
            ),
            SizedBox(height: Dimens.padding),
            _ResetForm(notifier: notifier),
            SizedBox(height: Dimens.padding),
          ],
        ),
      ),
    );
  }
}

class _ResetForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String?> _formFields = {};

  final StateNotifier<FormData?> notifier;

  _ResetForm({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  void _reset(BuildContext context, ResetState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.theme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.cardRadius),
        ),
      ),
      builder: (_) {
        return Container(
          padding: EdgeInsets.only(
            left: Dimens.contentPadding,
            right: Dimens.contentPadding,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BlocProvider(
            create: (_) => context.read<ResetBloc>().clone(),
            child: _ResetCode(),
          ),
        );
      },
    ).then((code) => _submit(context, code));
  }

  void _submit(BuildContext context, String? code) {
    if (_formKey.currentState == null || code == null) {
      return;
    }
    if (_formKey.currentState!.validate()) {
      context.read<ResetBloc>().add(
            OnResetEvent(code, _formFields[Strings.password]!),
          );
    }
  }

  void _onValidate(FormData data) {
    _formFields[data.name] = data.field.value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocConsumer<ResetBloc, ResetState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PasswordInput(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: !state.loading,
                validator: InputValidator(
                  key: Strings.password,
                  value: _formFields[Strings.password],
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
          BlocConsumer<ResetBloc, ResetState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PasswordInput(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: !state.loading,
                showSwitcher: false,
                validator: InputValidator(
                  key: Strings.confirmPassword,
                  value: _formFields[Strings.confirmPassword],
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
                        final pass = _formFields[Strings.password];
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
          BlocConsumer<ResetBloc, ResetState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PrimaryButton(
                context.text.proceed,
                outlined: false,
                spanWidth: true,
                showProgress: state.loading,
                onPressed: _onPressed(context, state),
              );
            },
          ),
        ],
      ),
    );
  }

  dynamic _onPressed(BuildContext context, ResetState state) {
    return state.isFormValid && !state.loading
        ? () => _reset(context, state)
        : null;
  }
}

class _ResetCode extends StatelessWidget {
  const _ResetCode({Key? key}) : super(key: key);

  void _validateCode(BuildContext context, String otp) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    context.read<ResetBloc>().add(VerifyCodeEvent(otp));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimens.contentPadding),
        SizedBox(
          width: double.infinity,
          child: Text(
            context.text.otpCaption,
            style: context.textTheme.bodyText1?.copyWith(
              height: 1.8,
            ),
          ),
        ),
        SizedBox(height: Dimens.padding),
        BlocConsumer<ResetBloc, ResetState>(
          listener: (context, state) {},
          builder: (context, state) {
            return PinInput(
              enabled: !state.loading,
              onCompleted: (pin) {},
              onChanged: (pin) => _validateCode(context, pin),
            );
          },
        ),
        SizedBox(height: Dimens.padding),
        BlocConsumer<ResetBloc, ResetState>(
          listener: (context, state) {},
          builder: (context, state) {
            return PrimaryButton(
              context.text.proceed,
              outlined: false,
              spanWidth: true,
              showProgress: state.loading,
              onPressed: _onPressed(context, state),
            );
          },
        ),
        SizedBox(height: Dimens.contentPadding),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }

  dynamic _onPressed(BuildContext context, ResetState state) {
    return state.isPinValid
        ? () => Navigator.pop(
              context,
              state.code,
            )
        : null;
  }
}
