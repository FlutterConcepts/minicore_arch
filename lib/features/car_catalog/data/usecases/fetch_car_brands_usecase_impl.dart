import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarBrandsUseCaseImpl implements FetchCarBrandsUseCase {
  FetchCarBrandsUseCaseImpl(this.repository);

  final ParallelumCarCatalogRepository repository;

  @override
  Future<CarCatalogState> call(void _) async {
    try {
      final (carBrands, errorMessage) = await repository.fetchCarBrands();

      if (errorMessage != null) {
        return CarCatalogFailure(errorMessage);
      } else {
        return CarBrandsSuccess(carBrands!);
      }
    } catch (error) {
      return CarCatalogFailure('Failed to fetch car brands catalog: $error');
    }
  }
}
