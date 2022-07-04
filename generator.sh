#!/bin/bash

MODULE=$1

FILE_NAME="$(tr '[:upper:]' '[:lower:]' <<< "$MODULE")"
CLASS_NAME="$(tr '[:lower:]' '[:upper:]' <<< "${MODULE:0:1}")${MODULE:1}"

SOURCE=$2
TARGET="./lib"

COMMON_PART="${SOURCE}/"
REAL_PATH=
while [ "${TARGET#$COMMON_PART}" = "${TARGET}" ]; do
  COMMON_PART=$(dirname "$COMMON_PART")
  REAL_PATH="../${REAL_PATH}"
done

read -r -d '' EVENT << EOM
import 'package:equatable/equatable.dart';

abstract class ${CLASS_NAME}Event extends Equatable {
  const ${CLASS_NAME}Event();

  @override
  List<Object> get props => [];
}
EOM

read -r -d '' STATE << EOM
import 'package:equatable/equatable.dart';

class ${CLASS_NAME}State extends Equatable {
  const ${CLASS_NAME}State();

  @override
  List<Object> get props => [];
}
EOM

read -r -d '' BLOC << EOM
import 'package:flutter_bloc/flutter_bloc.dart';

import '${FILE_NAME}_event.dart';
import '${FILE_NAME}_state.dart';

class ${CLASS_NAME}Bloc extends Bloc<${CLASS_NAME}Event, ${CLASS_NAME}State> {
  ${CLASS_NAME}Bloc() : super(const ${CLASS_NAME}State());

  @override
  Stream<${CLASS_NAME}State> mapEventToState(${CLASS_NAME}Event event) async* {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
EOM

read -r -d '' WIDGET << EOM
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '${REAL_PATH}screen/base/base.dart';

import '${FILE_NAME}_bloc.dart';
import '${FILE_NAME}_state.dart';
import '${FILE_NAME}_event.dart';

part '${FILE_NAME}_view.dart';

class ${CLASS_NAME} extends StatelessWidget {
  ${CLASS_NAME}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => ${CLASS_NAME}Bloc(),
          child: _${CLASS_NAME}View(),
        ),
      ),
    );
  }
}
EOM

read -r -d '' VIEW << EOM
part of '${FILE_NAME}.dart';

class _${CLASS_NAME}View extends StatefulWidget {
  @override
  __${CLASS_NAME}ViewState createState() => __${CLASS_NAME}ViewState();
}

class __${CLASS_NAME}ViewState extends BaseState<_${CLASS_NAME}View,
  ${CLASS_NAME}Bloc,
  ${CLASS_NAME}State> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('${CLASS_NAME}'),
      ),
    );
  }
}
EOM

read -r -d '' ROUTE << EOM
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '${REAL_PATH}common/common.dart';
import '${REAL_PATH}router/router.dart';

import '${FILE_NAME}.dart';

@Named('${CLASS_NAME}Route')
@injectable
class ${CLASS_NAME}Route extends KRouter {
  ${CLASS_NAME}Route();

  @override
  String path = '${FILE_NAME}';

  @override
  Widget? handlerFunc(BuildContext? context, RouteParam params) {
    return ${CLASS_NAME}();
  }
}
EOM

mkdir "$2/${FILE_NAME}"

echo "$EVENT" > "${SOURCE}/${FILE_NAME}/${FILE_NAME}_event.dart"
echo "$STATE" > "${SOURCE}/${FILE_NAME}/${FILE_NAME}_state.dart"
echo "$BLOC" > "${SOURCE}/${FILE_NAME}/${FILE_NAME}_bloc.dart"
echo "$WIDGET" > "${SOURCE}/${FILE_NAME}/${FILE_NAME}.dart"
echo "$VIEW" > "${SOURCE}/${FILE_NAME}/${FILE_NAME}_view.dart"
echo "$ROUTE" > "${SOURCE}/${FILE_NAME}/${FILE_NAME}_route.dart"