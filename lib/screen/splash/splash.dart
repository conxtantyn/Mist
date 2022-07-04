import 'dart:async';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sprung/sprung.dart';
import 'package:sizer/sizer.dart';

import '../../domain/domain.dart';
import '../../common/common.dart';
import '../../repository/repository.dart';
import '../../util/util.dart';

import '../base/base.dart';
import '../main/main.dart';
import '../partials/partials.dart';

import 'splash_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

part 'splash_view.dart';

class Splash extends StatelessWidget {
  final StartupUsecase startupUsecase;

  Splash({
    Key? key,
    required this.startupUsecase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        body: BlocProvider(
          create: (_) => SplashBloc(startupUsecase),
          child: _SplashView(),
        ),
      ),
    );
  }
}
