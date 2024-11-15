import 'package:flutter/material.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_states.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/usecases/fetch_car_catalog_usecase.dart';

class CarCatalogInteractor extends ValueNotifier<CarCatalogState> {
  final FetchCarCatalogUseCase fetchUseCase;

  CarCatalogInteractor({required this.fetchUseCase})
      : super(CarCatalogLoading());

  Future<void> fetch() async {
    value = CarCatalogLoading();
    final newState = await fetchUseCase.call();
    value = newState;
  }
}
