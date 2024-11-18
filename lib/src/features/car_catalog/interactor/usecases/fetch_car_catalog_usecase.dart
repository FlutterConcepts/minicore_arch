// ignore_for_file: one_member_abstracts

import 'package:minicore_arch_example/minicore_arch_example.dart';

/// Defines the contract for fetching the car catalog.
///
/// This use case is responsible for retrieving the state of the car catalog,
/// encapsulated within a [CarCatalogState].
abstract interface class FetchCarCatalogUseCase {
  /// Executes the use case to fetch the car catalog.
  ///
  /// Returns a [Future] that resolves to a [CarCatalogState],
  /// representing the result of the operation.
  Future<CarCatalogState> call();
}
