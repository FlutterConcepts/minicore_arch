import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogInteractor extends ValueNotifier<CarCatalogState> {
  CarCatalogInteractor({
    required this.fetchBrandsUseCase,
    required this.fetchModelsByBrandUseCase,
  }) : super(CarCatalogLoading());

  final FetchCarBrandsUseCase fetchBrandsUseCase;
  final FetchCarModelsByBrandUseCase fetchModelsByBrandUseCase;

  Future<void> fetchBrands() async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      final newState = await fetchBrandsUseCase.call();
      value = newState;
    });
  }

  Future<void> fetchModelsByBrand(int brandId) async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      final newState = await fetchModelsByBrandUseCase.call(brandId);
      value = newState;
    });
  }
}
