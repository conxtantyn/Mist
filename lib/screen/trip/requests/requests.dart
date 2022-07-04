import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../screen/base/base.dart';

import 'requests_bloc.dart';
import 'requests_state.dart';

part 'requests_view.dart';

class Requests extends StatelessWidget {
  Requests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => RequestsBloc(),
          child: _RequestsView(),
        ),
      ),
    );
  }
}
