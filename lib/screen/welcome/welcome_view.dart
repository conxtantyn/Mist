part of 'welcome.dart';

class _WelcomeView extends StatefulWidget {
  @override
  __WelcomeViewState createState() => __WelcomeViewState();
}

class __WelcomeViewState
    extends BaseState<_WelcomeView, WelcomeBloc, WelcomeState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Welcome'),
      ),
    );
  }
}
