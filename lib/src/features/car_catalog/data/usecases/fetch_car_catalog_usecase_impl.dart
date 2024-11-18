// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minicore_arch_example/minicore_arch_example.dart';

class FetchCarCatalogUseCaseImpl implements FetchCarCatalogUseCase {
  FetchCarCatalogUseCaseImpl(this.httpClient);
  final http.Client httpClient;

  @override
  Future<CarCatalogState> call() async {
    try {
      final response = await httpClient.get(
        Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'),
      );

      if (response.statusCode == 200) {
        final carCatalog = (jsonDecode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(CarMapper.fromJsonToEntity)
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
