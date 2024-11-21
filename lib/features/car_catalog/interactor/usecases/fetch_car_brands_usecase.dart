import 'package:minicore/minicore.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

abstract interface class FetchCarBrandsUseCase
    implements FutureUseCase<CarCatalogState, void> {
  @override
  Future<CarCatalogState> call(void _);
}
