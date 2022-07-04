part of 'recover.dart';

class _RecoverView extends StatefulWidget {
  @override
  __RecoverViewState createState() => __RecoverViewState();
}

class __RecoverViewState extends FormBlocState<_RecoverView, RecoverBloc,
    RecoverEvent, RecoverState> {
  @override
  RecoverEvent formEvent(bool isValid) => UpdateFormEvent(isValid);

  @override
  void onChange(RecoverState state) {
    if (state.error != null) {
      context.showError(state.error!);
    } else if (state.requestedRecovery) {
      context.read<PageRouter>().navigateTo(
            Routes.reset,
            context: context,
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
                  title: context.text.recoverLabel,
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
                context.text.recoverCaption,
                style: context.textTheme.bodyText1?.copyWith(
                  height: 1.8,
                ),
              ),
            ),
            SizedBox(height: Dimens.padding),
            _RecoverForm(notifier: notifier),
            SizedBox(height: Dimens.padding),
          ],
        ),
      ),
    );
  }
}

class _RecoverForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String?> _formFields = {};

  final StateNotifier<FormData?> notifier;

  _RecoverForm({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  void _onValidate(FormData data) {
    _formFields[data.name] = data.field.value;
  }

  void _recover(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<RecoverBloc>().add(
            OnRecover(_formFields[Strings.username]!),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final string = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocConsumer<RecoverBloc, RecoverState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TextFormField(
                style: theme.textTheme.subtitle2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: InputValidator(
                  key: Strings.username,
                  value: _formFields[Strings.username],
                  notifier: notifier,
                  onValidate: _onValidate,
                  validators: [
                    RequiredValidator(
                      errorText: context.text.usernameValidationText,
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
          BlocConsumer<RecoverBloc, RecoverState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PrimaryButton(
                string.proceed,
                outlined: false,
                spanWidth: true,
                showProgress: state.loading,
                onPressed: !state.isValidated || state.loading
                    ? null
                    : () => _recover(context),
              );
            },
          ),
          SizedBox(height: Dimens.padding),
        ],
      ),
    );
  }
}
