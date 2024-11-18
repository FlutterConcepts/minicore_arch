import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogPage extends StatefulWidget {
  const CarCatalogPage({super.key});

  @override
  State<CarCatalogPage> createState() => _CarCatalogPageState();
}

class _CarCatalogPageState extends State<CarCatalogPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await CarCatalogProvider.of(context, listen: false).fetchBrands();
    });
  }

  @override
  Widget build(BuildContext context) {
    final interactor = CarCatalogProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('MiniCore Arch Example'),
      ),
      body: switch (interactor.value) {
        CarCatalogLoading() => const Center(
            key: Key('CarCatalogLoading'),
            child: CircularProgressIndicator(),
          ),
        CarBrandsSuccess(carBrands: final List<CarBrandEntity> carBrands) =>
          ListView.builder(
            key: const Key('CarBrandsSuccess'),
            itemCount: carBrands.length,
            itemBuilder: (context, index) {
              final brand = carBrands[index];
              return ElevatedButton(
                onPressed: () {
                  interactor.fetchModelsByBrand(brand.code);
                },
                child: Text('Código: ${brand.code} | Marca: ${brand.name}'),
              );
            },
          ),
        CarModelsSuccess(carModels: final List<CarModelEntity> carModels) =>
          ListView.builder(
            key: const Key('CarModelsSuccess'),
            itemCount: carModels.length,
            itemBuilder: (context, index) {
              final model = carModels[index];
              return ElevatedButton(
                onPressed: () {},
                child: Text('Código: ${model.code} | Modelo: ${model.name}'),
              );
            },
          ),
        CarCatalogFailure(message: final String message) => Center(
            key: const Key('CarCatalogFailure'),
            child: Text(message),
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: interactor.fetchBrands,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
