import 'package:minicore_arch_example/minicore_arch_example.dart';

sealed class CarCatalogState {}

final class CarCatalogLoading implements CarCatalogState {}

final class CarBrandsSuccess implements CarCatalogState {
  const CarBrandsSuccess(this.carBrands);

  final List<CarBrandEntity> carBrands;
}

final class CarModelsSuccess implements CarCatalogState {
  const CarModelsSuccess(this.carModels);

  final List<CarModelEntity> carModels;
}

final class CarCatalogFailure implements CarCatalogState {
  const CarCatalogFailure(this.message);

  final String message;
}
