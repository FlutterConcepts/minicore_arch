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
      await CarCatalogProvider.of(context, listen: false).fetchCarBrands();
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
        CarBrandsSuccess(carBrands: final List<CarBrandModel> carBrands) =>
          ListView.builder(
            key: const Key('CarBrandsSuccess'),
            padding: const EdgeInsets.all(16),
            itemCount: carBrands.length,
            itemBuilder: (_, index) {
              final brand = carBrands[index];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: () =>
                        interactor.fetchCarModelsByBrand(brand.code),
                    child: Text('Código: ${brand.code} | Marca: ${brand.name}'),
                  ),
                ),
              );
            },
          ),
        CarModelsByBrandSuccess(
          carModels: final List<CarSpecModel> carModels
        ) =>
          ListView.builder(
            key: const Key('CarModelsByBrandSuccess'),
            padding: const EdgeInsets.all(16),
            itemCount: carModels.length,
            itemBuilder: (_, index) {
              final model = carModels[index];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Código: ${model.code} | Modelo: ${model.name}'),
                ),
              );
            },
          ),
        CarCatalogFailure(message: final String message) => Center(
            key: const Key('CarCatalogFailure'),
            child: Text(message),
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: interactor.fetchCarBrands,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
