import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarBrandsUseCaseImpl implements FetchCarBrandsUseCase {
  FetchCarBrandsUseCaseImpl(this.repository);

  final ParallelumCarCatalogRepository repository;

  @override
  Future<CarCatalogState> call(void _) async {
    return repository.fetchCarBrands();
  }
}
