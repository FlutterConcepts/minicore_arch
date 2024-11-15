import 'package:flutter/material.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_state.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/entities/car_entity.dart';
import 'package:minicore_arch_example/features/car_catalog/ui/car_catalog_provider.dart';

class CarCatalogPage extends StatefulWidget {
  const CarCatalogPage({super.key});
  @override
  State<CarCatalogPage> createState() => _CarCatalogPageState();
}

class _CarCatalogPageState extends State<CarCatalogPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CarCatalogProvider.of(context, listen: false).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final carCatalogInteractor = CarCatalogProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: switch (carCatalogInteractor.value) {
        CarCatalogLoading() => const Center(
            key: Key('CarCatalogLoading'),
            child: CircularProgressIndicator(),
          ),
        CarCatalogSuccess(carCatalog: final List<CarEntity> cars) =>
          ListView.builder(
            key: const Key('CarCatalogSuccess'),
            itemCount: cars.length,
            itemBuilder: (context, index) => Text(cars[index].name),
          ),
        CarCatalogFailure(message: final String message) => Center(
            key: const Key('CarCatalogFailure'),
            child: Text(message),
          ),
      },
      floatingActionButton:
          FloatingActionButton(onPressed: carCatalogInteractor.fetch),
    );
  }
}
