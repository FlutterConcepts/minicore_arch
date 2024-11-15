import 'package:flutter/material.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_state.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/usecases/load_car_catalog_usecase.dart';

class CarCatalogInteractor extends ValueNotifier<CarCatalogState> {
  final LoadCarCatalogUseCase loadUseCase;

  CarCatalogInteractor({required this.loadUseCase})
      : super(CarCatalogLoading());

  void fetchCarCatalog() async {
    value = CarCatalogLoading();
    final newState = await loadUseCase.call();
    value = newState;
  }
}
