// ignore_for_file: public_member_api_docs

import 'package:minicore_arch_example/minicore_arch_example.dart';

sealed class CarCatalogState {}

final class CarCatalogLoading implements CarCatalogState {}

final class CarCatalogSuccess implements CarCatalogState {
  const CarCatalogSuccess(this.carCatalog);
  final List<CarEntity> carCatalog;
}

final class CarCatalogFailure implements CarCatalogState {
  const CarCatalogFailure(this.message);
  final String message;
}
