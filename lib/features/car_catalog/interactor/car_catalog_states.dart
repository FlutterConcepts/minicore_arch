import 'package:minicore_arch_example/minicore_arch_example.dart';

sealed class CarCatalogState {}

final class CarCatalogLoading implements CarCatalogState {}

final class CarBrandsSuccess implements CarCatalogState {
  const CarBrandsSuccess(this.carBrands);

  final List<CarBrandModel> carBrands;
}

final class CarModelsByBrandSuccess implements CarCatalogState {
  const CarModelsByBrandSuccess(this.carModels);

  final List<CarSpecModel> carModels;
}

final class CarCatalogFailure implements CarCatalogState {
  const CarCatalogFailure(this.message);

  final String message;
}
