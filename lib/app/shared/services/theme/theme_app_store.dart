import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minicore_arch_example/app/shared/services/local_storage/shared_preferences_service.dart';
import 'package:minicore_arch_example/app/shared/services/theme/theme_app_state.dart';

class ThemeAppStore extends ValueNotifier<ThemeAppState> {
  final SharedPreferencesService prefs;

  ThemeAppStore(this.prefs) : super(ThemeAppState.initState());

  Future<void> getThemeApp() async {
    final themePrefs = await prefs.getThemeApp();
    ThemeEnum theme;

    themePrefs == ThemeEnum.darkTheme.name
        ? theme = ThemeEnum.darkTheme
        : theme = ThemeEnum.lightTheme;

    changeTheme(theme);
  }

  void changeTheme(ThemeEnum theme) {
    value = ThemeAppState(theme: theme);
    unawaited(prefs.saveThemeApp(theme: theme));
  }
}
