part of 'detail.dart';

class _DetailView extends StatefulWidget {
  @override
  __DetailViewState createState() => __DetailViewState();
}

class __DetailViewState extends BaseState<_DetailView,
  DetailBloc,
  DetailState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Detail'),
      ),
    );
  }
}
