import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../screen/base/base.dart';

import 'detail_bloc.dart';
import 'detail_state.dart';
import 'detail_event.dart';

part 'detail_view.dart';

class Detail extends StatelessWidget {
  Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => DetailBloc(),
          child: _DetailView(),
        ),
      ),
    );
  }
}
