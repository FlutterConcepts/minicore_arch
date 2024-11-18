// ignore_for_file: public_member_api_docs

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
      await CarCatalogProvider.of(context, listen: false).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final carCatalogInteractor = CarCatalogProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('MiniCore Arch Example'),
      ),
      body: switch (carCatalogInteractor.value) {
        CarCatalogLoading() => const Center(
            key: Key('CarCatalogLoading'),
            child: CircularProgressIndicator(),
          ),
        CarCatalogSuccess(carCatalog: final List<CarEntity> carCatalog) =>
          ListView.builder(
            key: const Key('CarCatalogSuccess'),
            itemCount: carCatalog.length,
            itemBuilder: (context, index) => Text(carCatalog[index].name),
          ),
        CarCatalogFailure(message: final String message) => Center(
            key: const Key('CarCatalogFailure'),
            child: Text(message),
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: carCatalogInteractor.fetch,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
