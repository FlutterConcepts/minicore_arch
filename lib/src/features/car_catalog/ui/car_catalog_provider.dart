import 'package:flutter/widgets.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarCatalogProvider extends InheritedNotifier<CarCatalogInteractor> {
  const CarCatalogProvider({
    required super.child,
    required CarCatalogInteractor interactor,
    super.key,
  }) : super(notifier: interactor);

  static CarCatalogInteractor of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<CarCatalogProvider>()!
          .notifier!;
    }
    return context
        .getInheritedWidgetOfExactType<CarCatalogProvider>()!
        .notifier!;
  }
}
