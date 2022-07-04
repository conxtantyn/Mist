import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/base.dart';

import 'welcome_bloc.dart';
import 'welcome_state.dart';

part 'welcome_view.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => WelcomeBloc(),
        child: _WelcomeView(),
      ),
    );
  }
}
