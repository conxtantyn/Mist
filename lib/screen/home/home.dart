import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/base.dart';
import '../main/main.dart';
import '../partials/partials.dart';

import 'home_bloc.dart';
import 'home_state.dart';

part 'home_view.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => HomeBloc(),
        child: TabScaffoldState(
          child: _HomeView(),
        ),
      ),
    );
  }
}
