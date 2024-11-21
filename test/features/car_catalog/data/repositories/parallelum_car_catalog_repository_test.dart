import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client mockClient;
  late String baseUrl;
  late CarCatalogRepository sut;

  setUp(() {
    mockClient = MockClient();
    baseUrl = faker.internet.httpsUrl();
    sut = ParallelumCarCatalogRepository(
      mockClient,
      baseUrl: baseUrl,
    );
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  group('fetchCarBrands Tests |', () {
    test(
        'Should return CarBrandsSuccess when API call succeeds with valid data',
        () async {
      // Arrange
      final mockResponseData = jsonEncode(
        List.generate(5, (_) {
          return {
            'code': faker.randomGenerator.integer(1000, min: 1).toString(),
            'name': faker.vehicle.model(),
          };
        }),
      );
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => Response(mockResponseData, 200));

      // Act
      final result = await sut.fetchCarBrands();

      // Assert
      expect(result, isA<CarBrandsSuccess>());
      final successState = result as CarBrandsSuccess;
      expect(successState.carBrands, isA<List<CarBrandModel>>());
      expect(successState.carBrands.length, 5);
      verify(() => mockClient.get(any())).called(1);
    });

    test(
        'Should return CarCatalogFailure when API call fails with a non-200 status code',
        () async {
      // Arrange
      const mockStatusCode = 404;
      final mockMessage = faker.lorem.sentence();
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => Response(mockMessage, mockStatusCode),
      );

      // Act
      final result = await sut.fetchCarBrands();

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(
        failureState.message,
        'Failed to fetch car brands catalog. Status code: $mockStatusCode',
      );
      verify(() => mockClient.get(any())).called(1);
    });

    test('should return CarCatalogFailure when an exception is thrown',
        () async {
      // Arrange
      final mockExceptionMessage = faker.lorem.sentence();
      when(() => mockClient.get(any()))
          .thenThrow(Exception(mockExceptionMessage));

      // Act
      final result = await sut.fetchCarBrands();

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(
        failureState.message,
        'Failed to fetch car brands catalog: Exception: $mockExceptionMessage',
      );
      verify(() => mockClient.get(any())).called(1);
    });
  });

  group('fetchCarModelsByBrand Tests |', () {
    test(
        'Should return CarModelsByBrandSuccess when API call succeeds with valid data',
        () async {
      // Arrange
      const brandId = 1;
      final mockResponseData = jsonEncode(
        List.generate(5, (_) {
          return {
            'code': faker.randomGenerator.integer(1000, min: 1).toString(),
            'name': faker.vehicle.model(),
          };
        }),
      );
      when(
        () => mockClient.get(Uri.parse('$baseUrl/cars/brands/$brandId/models')),
      ).thenAnswer(
        (_) async => Response(mockResponseData, 200),
      );

      // Act
      final result = await sut.fetchCarModelsByBrand(brandId);

      // Assert
      expect(result, isA<CarModelsByBrandSuccess>());
      final successState = result as CarModelsByBrandSuccess;
      expect(successState.carModels, isA<List<CarSpecModel>>());
      expect(successState.carModels.length, 5);
      verify(() => mockClient.get(any())).called(1);
    });

    test(
        'Should return CarCatalogFailure when API call fails with a non-200 status code',
        () async {
      // Arrange
      const brandId = 1;
      const mockStatusCode = 404;
      final mockMessage = faker.lorem.sentence();
      when(
        () => mockClient.get(Uri.parse('$baseUrl/cars/brands/$brandId/models')),
      ).thenAnswer(
        (_) async => Response(mockMessage, mockStatusCode),
      );

      // Act
      final result = await sut.fetchCarModelsByBrand(brandId);

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(
        failureState.message,
        'Failed to fetch car models catalog. Status code: $mockStatusCode',
      );
      verify(() => mockClient.get(any())).called(1);
    });

    test('Should return CarCatalogFailure when an exception is thrown',
        () async {
      // Arrange
      const brandId = 1;
      final mockExceptionMessage = faker.lorem.sentence();
      when(
        () => mockClient.get(Uri.parse('$baseUrl/cars/brands/$brandId/models')),
      ).thenThrow(Exception(mockExceptionMessage));

      // Act
      final result = await sut.fetchCarModelsByBrand(brandId);

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(
        failureState.message,
        'Failed to fetch car models catalog: Exception: $mockExceptionMessage',
      );
      verify(() => mockClient.get(any())).called(1);
    });
  });
}
