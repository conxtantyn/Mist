import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sprintf/sprintf.dart';
import 'package:sprung/sprung.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/domain.dart';
import '../../../common/common.dart';
import '../../../widget/widget.dart';
import '../../../validator/validator.dart';
import '../../../repository/repository.dart';
import '../../../util/util.dart';

import '../../base/base.dart';
import '../../main/main.dart';
import '../../partials/partials.dart';

import 'register_bloc.dart';
import 'register_state.dart';
import 'register_event.dart';
import 'register_action.dart';

part 'register_view.dart';

class Register extends StatelessWidget {
  final bool animated;
  final CreateUserUsecase createUserUsecase;

  Register({
    Key? key,
    required this.animated,
    required this.createUserUsecase,
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
            create: (_) => RegisterBloc(
              animated,
              createUserUsecase,
            ),
            child: BlocConsumer<MainBloc, MainState>(
              listener: (context, state) {},
              builder: (context, state) {
                return _RegisterView(
                  phone: state.account!.phone,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
