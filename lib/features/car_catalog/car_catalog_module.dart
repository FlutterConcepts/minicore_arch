import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogModule extends Module {
  static const String parentPath =
      AppModule.parentPath + AppModule.carCatalogPath;

  @override
  void binds(Injector i) {
    i.add<Client>(Client.new);
    i.add<ParallelumCarCatalogRepository>(
      () => ParallelumCarCatalogRepository(i.get<Client>(), baseUrl: baseUrl),
    );
    i.add<FetchCarBrandsUseCaseImpl>(
      () => FetchCarBrandsUseCaseImpl(i.get<ParallelumCarCatalogRepository>()),
    );
    i.add<FetchCarModelsByBrandUseCaseImpl>(
      () => FetchCarModelsByBrandUseCaseImpl(
        i.get<ParallelumCarCatalogRepository>(),
      ),
    );
    i.add<CarCatalogInteractor>(
      () => CarCatalogInteractor(
        fetchCarBrandsUseCase: i.get<FetchCarBrandsUseCaseImpl>(),
        fetchCarModelsByBrandUseCase: i.get<FetchCarModelsByBrandUseCaseImpl>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const CarCatalogPage());
  }
}
