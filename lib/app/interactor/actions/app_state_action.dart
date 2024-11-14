import 'dart:async';

import 'package:minicore_arch_example/app/injector.dart';
import 'package:minicore_arch_example/app/interactor/atoms/app_state_atoms.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_state.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_store.dart';

Future<void> getAppTheme() async {
  final themeStore = injector.get<AppThemeStore>();
  unawaited(themeStore.getAppTheme());
}

void changeTheme(ThemeType theme) {
  final themeStore = injector.get<AppThemeStore>();
  themeStore.changeTheme(theme);
}

void updateTheme(AppThemeState themeState) {
  AppSA.appStateAtom.value = AppSA.appStateAtom.value.copyWith(themeState: themeState);
}
