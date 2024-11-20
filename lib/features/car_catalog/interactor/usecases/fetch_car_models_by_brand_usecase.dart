import 'package:minicore_arch_example/minicore_arch_example.dart';

abstract interface class FetchCarModelsByBrandUseCase {
  Future<CarCatalogState> call(int brandId);
}
