import 'dart:convert';

import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class ParallelumCarCatalogRepository implements CarCatalogRepository {
  ParallelumCarCatalogRepository(
    this._client, {
    required this.baseUrl,
  });

  final Client _client;
  final String baseUrl;

  @override
  Future<CarCatalogState> fetchCarBrands() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/cars/brands'));

      if (response.statusCode == 200) {
        final carBrands = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarBrandModel.fromJson)
            .toList();

        return CarBrandsSuccess(carBrands);
      } else {
        return CarCatalogFailure(
          'Failed to fetch car brands catalog. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      return CarCatalogFailure(
        'Failed to fetch car brands catalog: $error',
      );
    }
  }

  @override
  Future<CarCatalogState> fetchCarModelsByBrand(int brandId) async {
    try {
      final response =
          await _client.get(Uri.parse('$baseUrl/cars/brands/$brandId/models'));

      if (response.statusCode == 200) {
        final carModels = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarSpecModel.fromJson)
            .toList();

        return CarModelsByBrandSuccess(carModels);
      } else {
        return CarCatalogFailure(
          'Failed to fetch car models catalog. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      return CarCatalogFailure(
        'Failed to fetch car models catalog: $error',
      );
    }
  }
}
