import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

/// The `CarCatalogInteractor` acts as the bridge between the UI and the business logic
/// for managing the car catalog.
///
/// It uses a [ValueNotifier] to track the current state of the car catalog
/// ([CarCatalogState]) and provides methods to fetch and update the catalog.
class CarCatalogInteractor extends ValueNotifier<CarCatalogState> {
  /// Creates a new instance of [CarCatalogInteractor].
  ///
  /// Requires a [FetchCarCatalogUseCase] to handle the business logic of fetching
  /// the car catalog data.
  CarCatalogInteractor(this.fetchUseCase) : super(CarCatalogLoading());

  /// The use case responsible for fetching the car catalog data.
  final FetchCarCatalogUseCase fetchUseCase;

  /// Fetches the car catalog data and updates the current [value].
  ///
  /// Initially sets the state to [CarCatalogLoading] before making the API call.
  /// After fetching the data, the state is updated with either:
  /// - [CarCatalogSuccess] if the data fetch succeeds.
  /// - [CarCatalogFailure] if an error occurs during the fetch process.
  ///
  /// A simulated delay of 2 seconds is used to mimic a real-world loading scenario.
  Future<void> fetch() async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 2), () async {
      final newState = await fetchUseCase.call();
      value = newState;
    });
  }
}
