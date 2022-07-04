import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../../validator/validator.dart';
import '../../../widget/widget.dart';
import '../../../repository/repository.dart';
import '../../../util/util.dart';

import '../../../screen/base/base.dart';
import '../../../screen/partials/partials.dart';

import 'recover_bloc.dart';
import 'recover_state.dart';
import 'recover_event.dart';

part 'recover_view.dart';

class Recover extends StatelessWidget {
  final PasswordRecoveryUsecase recoveryUsecase;

  Recover({
    Key? key,
    required this.recoveryUsecase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocProvider(
            create: (_) => RecoverBloc(recoveryUsecase),
            child: _RecoverView(),
          ),
        ),
      ),
    );
  }
}
