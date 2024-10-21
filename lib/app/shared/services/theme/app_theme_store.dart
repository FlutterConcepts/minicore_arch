import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minicore_arch_example/app/shared/services/local_storage/shared_preferences_service.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_state.dart';

class AppThemeStore extends ValueNotifier<AppThemeState> {
  final SharedPreferencesService prefs;

  AppThemeStore(this.prefs) : super(AppThemeState.initState());

  Future<void> getAppTheme() async {
    final themePrefs = await prefs.getAppTheme();
    ThemeType theme;

    themePrefs == ThemeType.darkTheme.name ? theme = ThemeType.darkTheme : theme = ThemeType.lightTheme;

    changeTheme(theme);
  }

  void changeTheme(ThemeType theme) {
    value = AppThemeState(theme: theme);
    unawaited(prefs.saveAppTheme(theme: theme));
  }
}
