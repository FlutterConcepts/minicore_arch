import 'package:minicore_arch_example/minicore_arch_example.dart';

abstract interface class CarCatalogRepository {
  Future<CarCatalogState> fetchCarBrands();
  Future<CarCatalogState> fetchCarModelsByBrand(int brandId);
}
