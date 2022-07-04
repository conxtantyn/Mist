import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

abstract class Skin extends AppThemeOptions {
  final Color border;

  final Color background;

  final Color muted;

  final Color info;

  final Color disabled;

  final Color success;

  final Color warning;

  final Color onInfo;

  final Color onDisabled;

  final Color onSuccess;

  final Color onWarning;

  final ColorScheme colorScheme;

  Skin({
    required this.border,
    required this.background,
    required this.muted,
    required this.info,
    required this.disabled,
    required this.success,
    required this.warning,
    required this.onInfo,
    required this.onDisabled,
    required this.onSuccess,
    required this.onWarning,
    required this.colorScheme,
  });
}
