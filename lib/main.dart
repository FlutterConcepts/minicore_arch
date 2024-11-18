import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

/// The main entry point of the application.
///
/// This function initializes and runs the Flutter application.
void main() {
  runApp(const App());
}

/// The root widget of the application.
///
/// The [App] sets up the dependency injection for the car catalog feature
/// and provides it to the rest of the application through the
/// [CarCatalogProvider].
class App extends StatelessWidget {
  /// Creates a new instance of the [App] widget.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // HTTP client used for API requests.
    final client = Client();

    // Use case for fetching the car catalog.
    final fetchBrandsUseCase = FetchCarBrandsUseCaseImpl(client);
    final fetchModelsByBrandUseCase = FetchCarModelsByBrandUseCaseImpl(client);

    // Interactor for managing the state of the car catalog.
    final interactor = CarCatalogInteractor(
      fetchBrandsUseCase: fetchBrandsUseCase,
      fetchModelsByBrandUseCase: fetchModelsByBrandUseCase,
    );

    return MaterialApp(
      title: 'MiniCore Arch',
      home: CarCatalogProvider(
        // Provides the car catalog interactor to the widget tree.
        interactor: interactor,
        child: const CarCatalogPage(),
      ),
    );
  }
}
