import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarModelsByBrandUseCaseImpl implements FetchCarModelsByBrandUseCase {
  FetchCarModelsByBrandUseCaseImpl(this.repository);

  final ParallelumCarCatalogRepository repository;

  @override
  Future<CarCatalogState> call(int brandId) async {
    try {
      final (carSpecs, errorMessage) =
          await repository.fetchCarModelsByBrand(brandId);

      if (errorMessage != null) {
        return CarCatalogFailure(errorMessage);
      } else {
        return CarModelsByBrandSuccess(carSpecs!);
      }
    } catch (error) {
      return CarCatalogFailure(
        'Failed to fetch car models catalog: $error',
      );
    }
  }
}
