import 'package:minicore/minicore.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

abstract interface class FetchCarModelsByBrandUseCase
    implements FutureUseCase<CarCatalogState, int> {
  @override
  Future<CarCatalogState> call(int brandId);
}
