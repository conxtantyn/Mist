import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/common.dart';
import '../../../widget/widget.dart';

import '../../../screen/base/base.dart';
import '../../../screen/main/main.dart';

import 'picker_bloc.dart';
import 'picker_state.dart';
import 'picker_event.dart';

part 'picker_view.dart';

class Picker extends StatelessWidget {
  Picker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (_) => PickerBloc(),
            child: _PickerView(),
          ),
        ),
      ),
    );
  }
}
