import 'dart:convert';

import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarModelsByBrandUseCaseImpl implements FetchCarModelsByBrandUseCase {
  FetchCarModelsByBrandUseCaseImpl(this.client);

  final Client client;

  @override
  Future<CarCatalogState> call(int brandId) async {
    try {
      final response = await client.get(
        Uri.parse('''
https://fipe.parallelum.com.br/api/v2/cars/brands/$brandId/models'''),
      );

      if (response.statusCode == 200) {
        final carModels = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarMapper.fromJsonToModel)
            .toList();

        return CarModelsSuccess(carModels);
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
