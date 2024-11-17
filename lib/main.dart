import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minicore_arch_example/features/car_catalog/data/usecases/fetch_car_catalog_usecase_impl.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_interactor.dart';
import 'package:minicore_arch_example/features/car_catalog/ui/car_catalog_page.dart';
import 'package:minicore_arch_example/features/car_catalog/ui/car_catalog_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final fetchUseCase = FetchCarCatalogUseCaseImpl(httpClient);
    final carCatalogInteractor = CarCatalogInteractor(fetchUseCase);

    return MaterialApp(
      title: 'MiniCore Arch',
      home: CarCatalogProvider(
        interactor: carCatalogInteractor,
        child: const CarCatalogPage(),
      ),
    );
  }
}
