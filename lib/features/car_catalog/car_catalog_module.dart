import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogModule extends Module {
  static const String parentPath =
      AppModule.parentPath + AppModule.carCatalogPath;

  @override
  void binds(Injector i) {
    i.addLazySingleton<Client>(Client.new);
    i.addLazySingleton<ParallelumCarCatalogRepository>(
      () => ParallelumCarCatalogRepository(i.get<Client>(), baseUrl: baseUrl),
    );
    i.addLazySingleton<CarCatalogInteractor>(
      () => CarCatalogInteractor(i.get<ParallelumCarCatalogRepository>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const CarCatalogPage());
  }
}
