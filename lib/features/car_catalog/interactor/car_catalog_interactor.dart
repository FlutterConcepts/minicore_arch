import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogInteractor extends ValueNotifier<CarCatalogState> {
  CarCatalogInteractor(this.repository) : super(CarCatalogLoading());

  final CarCatalogRepository repository;

  Future<void> fetchCarBrands() async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      final newState = await repository.fetchCarBrands();
      value = newState;
    });
  }

  Future<void> fetchCarModelsByBrand(int brandId) async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      final newState = await repository.fetchCarModelsByBrand(brandId);
      value = newState;
    });
  }
}
