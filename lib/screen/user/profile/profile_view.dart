part of 'profile.dart';

class _ProfileView extends StatefulWidget {
  @override
  __ProfileViewState createState() => __ProfileViewState();
}

class __ProfileViewState extends BaseState<_ProfileView,
  ProfileBloc,
  ProfileState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Profile'),
      ),
    );
  }
}
