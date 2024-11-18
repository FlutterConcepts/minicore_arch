import 'package:minicore_arch_example/minicore_arch_example.dart';

abstract interface class FetchCarBrandsUseCase {
  Future<CarCatalogState> call();
}
