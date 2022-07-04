import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../../repository/repository.dart';
import '../../../widget/widget.dart';
import '../../../validator/validator.dart';
import '../../../exception/exception.dart';
import '../../../util/util.dart';

import '../../../screen/base/base.dart';
import '../../../screen/partials/partials.dart';

import 'password_bloc.dart';
import 'password_state.dart';
import 'password_event.dart';

part 'password_view.dart';

class Password extends StatelessWidget {
  final PasswordLoginUsecase loginUsecase;

  Password({
    Key? key,
    required this.loginUsecase,
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
            create: (_) => PasswordBloc(loginUsecase),
            child: _PasswordView(),
          ),
        ),
      ),
    );
  }
}
