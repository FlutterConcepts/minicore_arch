import 'package:minicore/minicore.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

sealed class CarCatalogState implements State {}

final class CarCatalogLoading implements CarCatalogState {}

final class CarBrandsSuccess implements CarCatalogState {
  const CarBrandsSuccess(this.carBrands);

  final List<CarBrandModel> carBrands;
}

final class CarModelsByBrandSuccess implements CarCatalogState {
  const CarModelsByBrandSuccess(this.carSpecs);

  final List<CarSpecModel> carSpecs;
}

final class CarCatalogFailure implements CarCatalogState {
  const CarCatalogFailure(this.message);

  final String message;
}
