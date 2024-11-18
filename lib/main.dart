import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final client = Client();

    final fetchBrandsUseCase = FetchCarBrandsUseCaseImpl(client);
    final fetchModelsByBrandUseCase = FetchCarModelsByBrandUseCaseImpl(client);

    final interactor = CarCatalogInteractor(
      fetchBrandsUseCase: fetchBrandsUseCase,
      fetchModelsByBrandUseCase: fetchModelsByBrandUseCase,
    );

    return MaterialApp(
      title: 'MiniCore Arch',
      home: CarCatalogProvider(
        interactor: interactor,
        child: const CarCatalogPage(),
      ),
    );
  }
}
