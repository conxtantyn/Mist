import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../exception/exception.dart';

extension ErrorHandler on BuildContext {
  void showError(Exception ex, [SnackBarAction? action]) {
    final text = parseException(ex);
    final snackBar = SnackBar(
      duration: const Duration(days: 365),
      content: Text(text),
      action: action,
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showErrorWithRetryOption(Exception ex, VoidCallback action) {
    final text = parseException(ex);
    final snackBar = SnackBar(
      duration: const Duration(days: 365),
      content: Text(text),
      action: SnackBarAction(
        label: AppLocalizations.of(this)!.retry,
        onPressed: action,
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension ExceptionResolver on BuildContext {
  String parseException(Exception ex) {
    if (ex is LocationPermissionDeniedException) {
      return AppLocalizations.of(this)!.locationPermissionDenied;
    } else if (ex is LocationServiceDisabledException) {
      return AppLocalizations.of(this)!.locationServiceDisabled;
    } else if (ex is LocationException) {
      return AppLocalizations.of(this)!.locationError;
    } else if (ex is NoLoginAttemptException) {
      return AppLocalizations.of(this)!.invalidNumber;
    }
    return ex.toString().replaceFirst('Exception: ', '');
  }
}
