part of 'home.dart';

class _HomeView extends StatefulWidget {
  @override
  __HomeViewState createState() => __HomeViewState();
}

class __HomeViewState extends BaseState<_HomeView, HomeBloc, HomeState> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Text('Hello, ${state.account!.firstName}');
        },
      ),
    );
  }
}
