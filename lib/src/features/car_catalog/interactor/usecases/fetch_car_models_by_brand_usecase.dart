// ignore_for_file: one_member_abstracts

import 'package:minicore_arch_example/minicore_arch_example.dart';

/// Use case interface for fetching car models by brand.
///
/// This abstract interface defines a contract for fetching car models
/// associated with a specific brand. The implementation of this use case
/// should return the appropriate [CarCatalogState], which reflects the state
/// of the operation (e.g., loading, success, or failure).
abstract interface class FetchCarModelsByBrandUseCase {
  /// Fetches car models for a specific brand.
  ///
  /// Returns a [CarCatalogState], which can be one of the following:
  /// - [CarCatalogLoading]: If the operation is in progress.
  /// - [CarBrandsSuccess]: If the operation succeeds and returns car models.
  /// - [CarCatalogFailure]: If the operation fails, with an error message.
  Future<CarCatalogState> call(int brandId);
}
