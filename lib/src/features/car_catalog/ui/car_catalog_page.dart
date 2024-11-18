import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

/// A page that displays the car catalog.
///
/// The [CarCatalogPage] is a stateful widget that fetches and displays a list
/// of cars based on the current state of the [CarCatalogInteractor]. It also
/// provides a refresh button to refetch the car catalog.
class CarCatalogPage extends StatefulWidget {
  /// Creates a new instance of [CarCatalogPage].
  const CarCatalogPage({super.key});

  @override
  State<CarCatalogPage> createState() => _CarCatalogPageState();
}

class _CarCatalogPageState extends State<CarCatalogPage> {
  @override
  void initState() {
    super.initState();

    // Fetch the car catalog after the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await CarCatalogProvider.of(context, listen: false).fetch();
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
        // Displays a loading indicator while the catalog is being fetched.
        CarCatalogLoading() => const Center(
            key: Key('CarCatalogLoading'),
            child: CircularProgressIndicator(),
          ),
        // Displays a list of cars if the catalog is fetched successfully.
        CarCatalogSuccess(carCatalog: final List<CarBrandEntity> carCatalog) =>
          ListView.builder(
            key: const Key('CarCatalogSuccess'),
            itemCount: carCatalog.length,
            itemBuilder: (context, index) => Text('''
código: ${carCatalog[index].code} / marca: ${carCatalog[index].name}
'''),
          ),
        // Displays an error message if fetching the catalog fails.
        CarCatalogFailure(message: final String message) => Center(
            key: const Key('CarCatalogFailure'),
            child: Text(message),
          ),
      },
      floatingActionButton: FloatingActionButton(
        // Refetches the car catalog when pressed.
        onPressed: interactor.fetch,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
