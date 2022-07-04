part of 'requests.dart';

class _RequestsView extends StatefulWidget {
  @override
  __RequestsViewState createState() => __RequestsViewState();
}

class __RequestsViewState extends BaseState<_RequestsView,
  RequestsBloc,
  RequestsState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Requests'),
      ),
    );
  }
}
