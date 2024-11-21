import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWrapWidget(),
    ),
  );
}
