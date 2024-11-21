import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWrapWidget extends StatelessWidget {
  const AppWrapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MiniCore Arch',
      routerConfig: Modular.routerConfig,
    );
  }
}
