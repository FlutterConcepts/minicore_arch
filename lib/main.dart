import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiniCore Arch',
      initialRoute: CarCatalogModule.initialRoute,
      routes: {
        CarCatalogModule.initialRoute: (_) => const CarCatalogModule(),
      },
    );
  }
}
