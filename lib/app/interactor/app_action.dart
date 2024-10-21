import 'dart:async';

import 'package:minicore_arch_example/app/injector.dart';
import 'package:minicore_arch_example/app/interactor/app_atom.dart';
import 'package:minicore_arch_example/app/shared/services/theme/theme_app_state.dart';
import 'package:minicore_arch_example/app/shared/services/theme/theme_app_store.dart';

Future<void> getThemeApp() async {
  final themeStore = injector.get<ThemeAppStore>();
  unawaited(themeStore.getThemeApp());
}

void changeTheme(ThemeEnum theme) {
  final themeStore = injector.get<ThemeAppStore>();
  themeStore.changeTheme(theme);
}

void updateTheme(ThemeAppState themeState) {
  appState.value = appState.value.copyWith(themeState: themeState);
}
