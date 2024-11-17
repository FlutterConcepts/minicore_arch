import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minicore_arch_example/features/car_catalog/data/mappers/car_mapper.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_states.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/entities/car_entity.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/usecases/fetch_car_catalog_usecase.dart';

class FetchCarCatalogUseCaseImpl implements FetchCarCatalogUseCase {
  final http.Client httpClient;

  FetchCarCatalogUseCaseImpl(this.httpClient);

  @override
  Future<CarCatalogState> call() async {
    try {
      final response = await httpClient.get(
          Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'));

      if (response.statusCode == 200) {
        final List<CarEntity> carCatalog = (jsonDecode(response.body) as List)
            .map((json) => CarMapper.fromJsonToEntity(json))
            .toList();

        return CarCatalogSuccess(carCatalog);
      } else {
        return CarCatalogFailure(
            'Failed to fetch car catalog. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return CarCatalogFailure(
          'Failed to fetch car catalog: ${error.toString()}');
    }
  }
}
