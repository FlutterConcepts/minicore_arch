import 'package:minicore/minicore.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogInteractor extends Interactor<CarCatalogState> {
  CarCatalogInteractor({
    required this.fetchCarBrandsUseCase,
    required this.fetchCarModelsByBrandUseCase,
  }) : super(CarCatalogLoading());

  final FetchCarBrandsUseCase fetchCarBrandsUseCase;
  final FetchCarModelsByBrandUseCase fetchCarModelsByBrandUseCase;

  Future<void> fetchCarBrands() async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      value = await fetchCarBrandsUseCase(null);
    });
  }

  Future<void> fetchCarModelsByBrand(int brandId) async {
    value = CarCatalogLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      value = await fetchCarModelsByBrandUseCase(brandId);
    });
  }
}
