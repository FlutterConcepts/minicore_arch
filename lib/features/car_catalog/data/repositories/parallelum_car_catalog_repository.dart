import 'dart:convert';

import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class ParallelumCarCatalogRepository {
  ParallelumCarCatalogRepository(
    this._client, {
    required this.baseUrl,
  });

  final Client _client;
  final String baseUrl;

  Future<(List<CarBrandModel>? carBrands, String? errorMessage)>
      fetchCarBrands() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/cars/brands'));

      if (response.statusCode == 200) {
        final carBrands = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarBrandModel.fromJson)
            .toList();

        return (carBrands, null);
      } else {
        return (
          null,
          'Failed to fetch car brands catalog. Status code: ${response.statusCode}'
        );
      }
    } catch (error) {
      return (null, 'Failed to fetch car brands catalog: $error');
    }
  }

  Future<(List<CarSpecModel>? carSpecs, String? errorMessage)>
      fetchCarModelsByBrand(
    int brandId,
  ) async {
    try {
      final response =
          await _client.get(Uri.parse('$baseUrl/cars/brands/$brandId/models'));

      if (response.statusCode == 200) {
        final carSpecs = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarSpecModel.fromJson)
            .toList();

        return (carSpecs, null);
      } else {
        return (
          null,
          'Failed to fetch car models catalog. Status code: ${response.statusCode}'
        );
      }
    } catch (error) {
      return (null, 'Failed to fetch car models catalog: $error');
    }
  }
}
