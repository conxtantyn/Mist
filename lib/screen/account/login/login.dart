import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprung/sprung.dart';

import '../../../domain/domain.dart';
import '../../../common/common.dart';
import '../../../widget/widget.dart';
import '../../../repository/repository.dart';
import '../../../util/util.dart';

import '../../base/base.dart';
import '../../main/main.dart';
import '../../partials/partials.dart';

import 'login_bloc.dart';
import 'login_state.dart';
import 'login_event.dart';

part 'login_view.dart';

class Login extends StatelessWidget {
  final bool animated;
  final AuthUsecase authUsecase;

  Login({
    Key? key,
    required this.animated,
    required this.authUsecase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (_) => LoginBloc(
              animated,
              authUsecase,
            ),
            child: _LoginView(),
          ),
        ),
      ),
    );
  }
}
