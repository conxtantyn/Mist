import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:sprintf/sprintf.dart';

import '../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../../widget/widget.dart';
import '../../../util/util.dart';
import '../../../repository/repository.dart';

import '../../base/base.dart';
import '../../main/main.dart';
import '../../partials/partials.dart';

import 'verification_bloc.dart';
import 'verification_state.dart';
import 'verification_event.dart';
import 'verification_action.dart';

part 'verification_view.dart';

class Verification extends StatelessWidget {
  final AuthUsecase authUsecase;
  final ProcessOtpUsecase processOtpUsecase;
  final LastLoginAttemptUsecase attemptUsecase;

  Verification({
    Key? key,
    required this.authUsecase,
    required this.processOtpUsecase,
    required this.attemptUsecase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: context.read<Skin>().colorScheme.onSurface,
            ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: BlocProvider(
          create: (_) => VerificationBloc(
            authUsecase,
            processOtpUsecase,
            attemptUsecase,
          ),
          child: _VerificationView(),
        ),
      ),
    );
  }
}
