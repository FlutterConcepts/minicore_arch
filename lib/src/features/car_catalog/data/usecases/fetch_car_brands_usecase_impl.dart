import 'dart:convert';

import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

/// Implementation of [FetchCarBrandsUseCase] for fetching the car catalog.
///
/// This class interacts with an external API to retrieve the car catalog data
/// and returns the result as a [CarCatalogState].
class FetchCarBrandsUseCaseImpl implements FetchCarBrandsUseCase {
  /// Creates an instance of [FetchCarBrandsUseCaseImpl].
  ///
  /// Requires an [client] to perform HTTP requests.
  FetchCarBrandsUseCaseImpl(this.client);

  /// The HTTP client used to make requests to the API.
  final Client client;

  /// Fetches the car catalog from an external API.
  ///
  /// - If the response is successful (status code 200), the car catalog is
  ///   parsed into a list of [CarBrandEntity] and returned as a [CarCatalogSuccess].
  /// - If the response is unsuccessful, a [CarCatalogFailure] is returned
  ///   with an error message.
  /// - If an exception occurs during the request or parsing, a
  ///   [CarCatalogFailure] is returned with the error details.
  ///
  /// Returns a [Future] that resolves to a [CarCatalogState].
  @override
  Future<CarCatalogState> call() async {
    try {
      final response = await client.get(
        Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'),
        // Uri.parse('https://parallelum.com.br/fipe/api/v2/cars/brands'),
      );

      if (response.statusCode == 200) {
        final carCatalog = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarMapper.fromJsonToBrand)
            .toList();

        return CarCatalogSuccess(carCatalog);
      } else {
        return CarCatalogFailure(
          'Failed to fetch car catalog. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      return CarCatalogFailure(
        'Failed to fetch car catalog: $error',
      );
    }
  }
}
