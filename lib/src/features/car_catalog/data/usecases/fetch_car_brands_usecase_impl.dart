import 'dart:convert';

import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarBrandsUseCaseImpl implements FetchCarBrandsUseCase {
  FetchCarBrandsUseCaseImpl(this.client);

  final Client client;

  @override
  Future<CarCatalogState> call() async {
    try {
      final response = await client.get(
        Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'),
        // Uri.parse('https://parallelum.com.br/fipe/api/v2/cars/brands'),
      );

      if (response.statusCode == 200) {
        final carBrands = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarMapper.fromJsonToBrand)
            .toList();

        return CarBrandsSuccess(carBrands);
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
