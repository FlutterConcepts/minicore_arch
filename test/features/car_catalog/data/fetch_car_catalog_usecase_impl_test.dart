import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:minicore_arch_example/features/car_catalog/data/usecases/fetch_car_catalog_usecase_impl.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_state.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/entities/car_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late FetchCarCatalogUseCaseImpl fetchCarCatalogUseCase;

  setUp(() {
    mockHttpClient = MockHttpClient();
    fetchCarCatalogUseCase =
        FetchCarCatalogUseCaseImpl(httpClient: mockHttpClient);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  group('FetchCarCatalogUseCase', () {
    test(
        'should return CarCatalogSuccess when API call succeeds with valid data',
        () async {
      // Arrange
      final mockResponseData = jsonEncode([
        {'codigo': '001', 'nome': 'Car A'},
        {'codigo': '002', 'nome': 'Car B'}
      ]);

      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(mockResponseData, 200),
      );

      // Act
      final result = await fetchCarCatalogUseCase.call();

      // Assert
      expect(result, isA<CarCatalogSuccess>());
      final successState = result as CarCatalogSuccess;
      expect(successState.carCatalog.length, 2);
      expect(successState.carCatalog[0], isA<CarEntity>());
      expect(successState.carCatalog[0].code, '001');
      expect(successState.carCatalog[0].name, 'Car A');
    });

    test(
        'should return CarCatalogFailure when API call fails with a non-200 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      // Act
      final result = await fetchCarCatalogUseCase.call();

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(failureState.message,
          'Failed to fetch car catalog. Status code: 404');
    });

    test('should return CarCatalogFailure when an exception is thrown',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenThrow(Exception('Network error'));

      // Act
      final result = await fetchCarCatalogUseCase.call();

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(failureState.message,
          'Failed to fetch car catalog: Exception: Network error');
    });
  });
}
