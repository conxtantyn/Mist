import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sprintf/sprintf.dart';
import 'package:sprung/sprung.dart';

import '../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../../widget/widget.dart';
import '../../../validator/validator.dart';
import '../../../repository/repository.dart';
import '../../../util/util.dart';

import '../../../screen/base/base.dart';
import '../../../screen/partials/partials.dart';

import 'reset_bloc.dart';
import 'reset_state.dart';
import 'reset_event.dart';

part 'reset_view.dart';

class Reset extends StatelessWidget {
  final PasswordResetUsecase resetUsecase;

  Reset({Key? key, required this.resetUsecase}) : super(key: key);

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
            create: (_) => ResetBloc(resetUsecase),
            child: _ResetView(),
          ),
        ),
      ),
    );
  }
}
