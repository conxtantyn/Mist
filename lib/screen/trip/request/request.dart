import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../screen/base/base.dart';

import 'request_bloc.dart';
import 'request_state.dart';

part 'request_view.dart';

class Request extends StatelessWidget {
  Request({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => RequestBloc(),
          child: _RequestView(),
        ),
      ),
    );
  }
}
