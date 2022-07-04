part of 'password.dart';

class _PasswordView extends StatefulWidget {
  @override
  __PasswordViewState createState() => __PasswordViewState();
}

class __PasswordViewState extends FormBlocState<_PasswordView, PasswordBloc,
    PasswordEvent, PasswordState> {
  @override
  PasswordEvent formEvent(bool isValid) => UpdateFormEvent(isValid);

  @override
  void onChange(PasswordState state) {
    if (state.error is NoLoginAttemptException) {
      _showError(state.error!);
    } else if (state.error?.error is UnAuthorizedUserException) {
      _showUnAuthorizedUserError();
    } else if (state.error != null) {
      context.showError(state.error!);
    } else if (state.isAuthenticated) {
      _toHome();
    }
    super.onChange(state);
  }

  void _showError(Exception error) {
    context.showError(
      error,
      SnackBarAction(
        label: AppLocalizations.of(context)!.retry,
        onPressed: _toLogin,
      ),
    );
  }

  void _showUnAuthorizedUserError() {
    context.showError(
      Exception(AppLocalizations.of(context)!.indexNotFound),
      SnackBarAction(
        label: AppLocalizations.of(context)!.retry,
        onPressed: _toLogin,
      ),
    );
  }

  void _toLogin() {
    context.read<PageRouter>().navigateTo(
          Routes.login,
          context: context,
          clearStack: true,
          params: [Routes.verification.md5()],
          transition: TransitionType.cupertino,
        );
  }

  void _toHome() {
    context.read<PageRouter>().navigateTo(
          Routes.home,
          context: context,
          clearStack: true,
          params: [Routes.verification.md5()],
          transition: TransitionType.cupertino,
        );
  }

  void _toPasswordRecovery(url) {
    context.read<PageRouter>().navigateTo(
          Routes.recover,
          context: context,
          transition: TransitionType.cupertino,
        );
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
                  title: context.text.passwordLoginLabel,
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
          children: [
            SizedBox(height: Dimens.padding * .5),
            SizedBox(
              width: double.infinity,
              child: Text(
                context.text.passwordCaption,
                style: context.textTheme.bodyText1,
              ),
            ),
            SizedBox(height: Dimens.padding),
            _PasswordForm(notifier: notifier),
            SizedBox(height: Dimens.padding),
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
          text: context.text.passwordRecoveryText,
          style: context.textTheme.overline,
          alignment: TextAlign.center,
          parse: [
            MatchText(
              pattern: r'' + context.text.clickHere,
              style: context.textTheme.overline?.copyWith(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              onTap: _toPasswordRecovery,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String?> _formFields = {};

  final StateNotifier<FormData?> notifier;

  _PasswordForm({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  void _onValidate(FormData data) {
    _formFields[data.name] = data.field.value;
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<PasswordBloc>().add(
            OnLogin(_formFields[Strings.password]!),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocConsumer<PasswordBloc, PasswordState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PasswordInput(
                enabled: !state.loading,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: InputValidator(
                  key: Strings.password,
                  value: _formFields[Strings.password],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    RequiredValidator(
                      errorText: context.text.passwordValidationText,
                    ),
                  ],
                ),
                decoration: InputDecoration(
                  hintText: context.text.password,
                ),
              );
            },
          ),
          SizedBox(height: Dimens.padding * 2),
          BlocConsumer<PasswordBloc, PasswordState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PrimaryButton(
                context.text.proceed,
                outlined: false,
                spanWidth: true,
                showProgress: state.loading,
                onPressed: !state.isValidated || state.loading
                    ? null
                    : () => _login(context),
              );
            },
          ),
          SizedBox(height: Dimens.padding),
        ],
      ),
    );
  }
}
