import 'package:flutter/widgets.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

/// Provides access to the `CarCatalogInteractor` throughout the widget tree.
///
/// The `CarCatalogProvider` is an implementation of [InheritedNotifier], which allows
/// widgets to access and listen to updates from the [CarCatalogInteractor].
///
/// This provider simplifies state management by exposing the [CarCatalogInteractor]
/// via the [of] method, ensuring that the widget tree can react to changes in the car catalog state.
class CarCatalogProvider extends InheritedNotifier<CarCatalogInteractor> {
  /// Creates an instance of [CarCatalogProvider].
  ///
  /// - [child] is the widget subtree that can access the [CarCatalogInteractor].
  /// - [interactor] is the [CarCatalogInteractor] used to manage the car catalog state.
  const CarCatalogProvider({
    required super.child,
    required CarCatalogInteractor interactor,
    super.key,
  }) : super(notifier: interactor);

  /// Retrieves the [CarCatalogInteractor] from the nearest [CarCatalogProvider].
  ///
  /// - [context] is the [BuildContext] used to locate the provider in the widget tree.
  /// - [listen] determines whether the caller should be rebuilt when the interactor
  ///   notifies its listeners. Defaults to `true`.
  ///
  /// Throws an error if no [CarCatalogProvider] is found in the widget tree.
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
