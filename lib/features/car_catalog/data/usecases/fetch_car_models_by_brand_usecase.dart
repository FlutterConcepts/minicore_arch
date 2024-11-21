import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarModelsByBrandUseCaseImpl implements FetchCarModelsByBrandUseCase {
  FetchCarModelsByBrandUseCaseImpl(this.repository);

  final ParallelumCarCatalogRepository repository;

  @override
  Future<CarCatalogState> call(int brandId) async {
    return repository.fetchCarBrands();
  }
}
