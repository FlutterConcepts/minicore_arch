import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarModelsByBrandUseCaseImpl implements FetchCarModelsByBrandUseCase {
  FetchCarModelsByBrandUseCaseImpl(this.repository);

  final ParallelumCarCatalogRepository repository;

  @override
  Future<CarCatalogState> call(int brandId) async {
    try {
      final (carModels, errorMessage) =
          await repository.fetchCarModelsByBrand(brandId);

      if (errorMessage != null) {
        return CarCatalogFailure(errorMessage);
      } else {
        return CarModelsByBrandSuccess(carModels!);
      }
    } catch (error) {
      return CarCatalogFailure('$error');
    }
  }
}
