import 'package:minicore_arch_example/minicore_arch_example.dart';

/// Represents the base class for the different states of the car catalog.
///
/// This class is sealed, meaning only its subclasses can be used to represent
/// the state of the car catalog in the application.
sealed class CarCatalogState {}

/// Represents the loading state of the car catalog.
///
/// This state indicates that the car catalog is in the process of being
/// fetched.
final class CarCatalogLoading implements CarCatalogState {}

/// Represents the success state of the car catalog.
///
/// This state indicates that the car catalog was successfully fetched,
/// and it contains a list of [CarBrandEntity].
final class CarCatalogSuccess implements CarCatalogState {
  /// Creates an instance of [CarCatalogSuccess].
  ///
  /// Accepts a [carCatalog], which is a list of [CarBrandEntity] representing
  /// the fetched car catalog data.
  const CarCatalogSuccess(this.carCatalog);

  /// The list of car entities retrieved from the car catalog.
  final List<CarBrandEntity> carCatalog;
}

/// Represents the failure state of the car catalog.
///
/// This state indicates that there was an error while fetching the car catalog.
final class CarCatalogFailure implements CarCatalogState {
  /// Creates an instance of [CarCatalogFailure].
  ///
  /// Accepts a [message], which provides details about the error.
  const CarCatalogFailure(this.message);

  /// The error message describing the failure reason.
  final String message;
}
