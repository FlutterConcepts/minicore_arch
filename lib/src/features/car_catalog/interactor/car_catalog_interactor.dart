// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogInteractor extends ValueNotifier<CarCatalogState> {
  CarCatalogInteractor(this.fetchUseCase) : super(CarCatalogLoading());
  final FetchCarCatalogUseCase fetchUseCase;

  Future<void> fetch() async {
    value = CarCatalogLoading();
    final newState = await fetchUseCase.call();
    value = newState;
  }
}
