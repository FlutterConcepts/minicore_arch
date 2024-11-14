import 'dart:async';
import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:minicore_arch_example/app/injector.dart';
import 'package:minicore_arch_example/app/interactor/app_action.dart';
import 'package:minicore_arch_example/app/interactor/app_atom.dart';
import 'package:minicore_arch_example/app/interactor/app_state.dart';
import 'package:minicore_arch_example/app/router_config.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_state.dart';
import 'package:minicore_arch_example/app/shared/services/theme/app_theme_store.dart';
// import 'routes.dart.bak';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppThemeStore themeStore = injector.get<AppThemeStore>();
  @override
  void initState() {
    super.initState();
    unawaited(getAppTheme());
    themeStore.addListener(() {
      updateTheme(themeStore.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color selectedColor = Color(0xff121322);
    const Brightness selectedBrightness = Brightness.light;
    final AppState state = context.select(() => appState.value);

    log(state.toString());

    return MaterialApp.router(
      title: 'Tractian',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: selectedColor,
          brightness: selectedBrightness,
        ),
      ),
      themeMode: state.themeState.theme == ThemeType.lightTheme
          ? ThemeMode.light
          : ThemeMode.dark,
      routerConfig: appRouterConfig,
    );
  }
}
