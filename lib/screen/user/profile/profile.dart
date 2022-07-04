import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../screen/base/base.dart';

import 'profile_bloc.dart';
import 'profile_state.dart';
import 'profile_event.dart';

part 'profile_view.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => ProfileBloc(),
          child: _ProfileView(),
        ),
      ),
    );
  }
}
