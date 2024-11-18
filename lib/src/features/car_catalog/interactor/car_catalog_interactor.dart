import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

/// The `CarCatalogInteractor` acts as the bridge between the UI and the
/// business logic
/// for managing the car catalog.
///
/// It uses a [ValueNotifier] to track the current state of the car catalog
/// ([CarCatalogState]) and provides methods to fetch and update the catalog.
class CarCatalogInteractor extends ValueNotifier<CarCatalogState> {
  /// Creates a new instance of [CarCatalogInteractor].
  ///
  /// Requires a [FetchCarBrandsUseCase] to handle the business logic of
  /// fetching
  /// the car catalog data.
  CarCatalogInteractor({
    required this.fetchBrandsUseCase,
    required this.fetchModelsByBrandUseCase,
  }) : super(CarCatalogLoading());

  /// The use case responsible for fetching the car catalog data.
  final FetchCarBrandsUseCase fetchBrandsUseCase;
  final FetchCarModelsByBrandUseCase fetchModelsByBrandUseCase;

  Future<void> fetchBrands() async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 2), () async {
      final newState = await fetchBrandsUseCase.call();
      value = newState;
    });
  }

  Future<void> fetchModelsByBrand(int brandId) async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 2), () async {
      final newState = await fetchModelsByBrandUseCase.call(brandId);
      value = newState;
    });
  }
}
