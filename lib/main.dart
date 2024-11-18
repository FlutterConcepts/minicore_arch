// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minicore_arch_example/minicore_arch_example.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final fetchUseCase = FetchCarCatalogUseCaseImpl(httpClient);
    final interactor = CarCatalogInteractor(fetchUseCase);

    return MaterialApp(
      title: 'MiniCore Arch',
      home: CarCatalogProvider(
        interactor: interactor,
        child: const CarCatalogPage(),
      ),
    );
  }
}
