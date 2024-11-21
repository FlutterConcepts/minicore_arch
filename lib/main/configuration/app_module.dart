import 'package:flutter_modular/flutter_modular.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class AppModule extends Module {
  /// PARENT PATH
  static const String parentPath = '';

  /// PATHS
  static const String carCatalogPath = '/cars/catalog';

  /// ROUTES
  static String get carCatalogRoute => parentPath + carCatalogPath;

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    /// REDIRECTS
    r.redirect('/', to: carCatalogRoute);

    /// MODULES
    r.module(carCatalogPath, module: CarCatalogModule());

    /// PAGES
  }
}
