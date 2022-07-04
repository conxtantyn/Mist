part of 'request.dart';

class _RequestView extends StatefulWidget {
  @override
  __RequestViewState createState() => __RequestViewState();
}

class __RequestViewState extends BaseState<_RequestView,
  RequestBloc,
  RequestState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Request'),
      ),
    );
  }
}
