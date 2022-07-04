part of 'splash.dart';

final Duration _kAnimDuration = Duration(milliseconds: 800);

class _SplashView extends StatefulWidget {
  @override
  __SplashViewState createState() => __SplashViewState();
}

class __SplashViewState extends BaseState<_SplashView, SplashBloc, SplashState>
    with TickerProviderStateMixin {
  AnimationController? _animController;

  @override
  void initState() {
    final ms = (_kAnimDuration.inMilliseconds * 1.5).toInt();
    _animController = AnimationController(
      vsync: this,
      duration: _kAnimDuration,
      reverseDuration: Duration(milliseconds: ms),
    );
    context.read<MainBloc>().observer.listen(_onMainAction).include(steams);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration duration) => _initialize(),
    );
    super.initState();
  }

  void _onMainAction(MainAction? action) {
    context.read<PageRouter>().navigate(context, action);
  }

  void _initialize() {
    final locale = Localizations.localeOf(context);
    context.read<SplashBloc>().add(
          OnInitializeEvent(locale, _kAnimDuration),
        );
  }

  @override
  void onChange(SplashState state) {
    super.onChange(state);
    if (state.isEnabled) {
      _animController?.forward();
    } else if (state.error == null) {
      _animController?.reverse();
    }
    if (state.error != null) {
      context.showErrorWithRetryOption(state.error!, _initialize);
    } else if (state.isReady) {
      context.read<MainBloc>().add(
            StartupEvent(state.config!, state.account),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(vertical: Dimens.padding * 2.5),
      const EdgeInsets.symmetric(vertical: Dimens.padding * 2),
      const EdgeInsets.symmetric(vertical: Dimens.padding * 1.5),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return Material(
      child: _SplashContainer(
        animController: _animController!,
        child: Stack(
          children: [
            Center(
              child: _SplashTitle(
                title: Text(
                  context.text.loadingText,
                  style: context.textTheme.bodyText1?.copyWith(
                    color: context.read<Skin>().colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                padding: scaledPadding,
              ),
            ),
            Center(
              child: _SplashLogo(
                padding: scaledPadding,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }
}

class _SplashContainer extends StatelessWidget {
  final Animation<double> animation;

  final AnimationController animController;

  final Widget child;

  _SplashContainer({
    Key? key,
    required this.animController,
    required this.child,
  })  : animation = CurvedAnimation(
          parent: animController,
          curve: Sprung.overDamped,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularRevealAnimation(
      animation: animation,
      maxRadius: kLogoRatio.w,
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, animationChild) {
          return Opacity(
            opacity: animation.value,
            child: animationChild,
          );
        },
        child: child,
      ),
    );
  }
}

class _SplashTitle extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget title;

  const _SplashTitle({
    Key? key,
    required this.padding,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AnimatedPadding(
          padding: EdgeInsets.only(
            top: state.isEnabled ? padding.vertical / 1.5 : 0,
            bottom: Dimens.padding,
          ),
          curve: Sprung.overDamped,
          duration: _kAnimDuration,
          child: AnimatedOpacity(
            opacity: state.isEnabled ? 1 : 0,
            duration: _kAnimDuration,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSwitcher(
                  duration: kAnimationDuration,
                  child: state.loading
                      ? GlowingProgressIndicator(child: title)
                      : title,
                ),
              ),
              height: kLogoRatio.w,
            ),
          ),
        );
      },
    );
  }
}

class _SplashLogo extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const _SplashLogo({
    Key? key,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AnimatedPadding(
          padding: EdgeInsets.only(
            bottom: state.isEnabled ? padding.vertical / 1.5 : 0,
          ),
          curve: Sprung.overDamped,
          duration: _kAnimDuration,
          child: LogoBox(),
        );
      },
    );
  }
}
