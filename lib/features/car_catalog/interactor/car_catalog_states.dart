import 'package:minicore_arch_example/features/car_catalog/interactor/entities/car_entity.dart';

sealed class CarCatalogState {}

final class CarCatalogLoading implements CarCatalogState {}

final class CarCatalogSuccess implements CarCatalogState {
  final List<CarEntity> carCatalog;
  const CarCatalogSuccess({required this.carCatalog});
}

final class CarCatalogFailure implements CarCatalogState {
  final String message;
  const CarCatalogFailure(this.message);
}
