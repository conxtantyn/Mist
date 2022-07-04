import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../common/common.dart';
import '../router/router.dart';
import '../repository/router.dart';
import '../screen/main/main.dart';

extension IndexNavigator on PageRouter {
  void navigate(BuildContext context, MainAction? action) {
    if (action is NavigateToIndex) {
      navigateTo(
        (action.account == null)
            ? Routes.login
            : (action.account?.id == -1)
                ? Routes.register
                : Routes.home,
        clearStack: true,
        context: context,
        transitionDuration:
            (action.transition) ? kPageTransitionDuration : Duration.zero,
        transition: (action.transition)
            ? TransitionType.cupertino
            : TransitionType.none,
        params: [!action.transition],
      );
    }
  }
}
