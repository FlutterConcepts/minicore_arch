import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  const brandId = 1;
  late Client mockClient;
  late String baseUrl;
  late ParallelumCarCatalogRepository sut;

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
      final (carBrands, errorMessage) = await sut.fetchCarBrands();

      // Assert
      expect(carBrands, isA<List<CarBrandModel>>());
      expect(carBrands!.length, 5);
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
      final (carBrands, errorMessage) = await sut.fetchCarBrands();

      // Assert
      expect(carBrands, isNull);
      expect(
        errorMessage,
        'Failed to fetch car brands catalog. Status code: $mockStatusCode',
      );
    });

    test('should return CarCatalogFailure when an exception is thrown',
        () async {
      // Arrange
      final mockExceptionMessage = faker.lorem.sentence();
      when(() => mockClient.get(any()))
          .thenThrow(Exception(mockExceptionMessage));

      // Act
      final (carBrands, errorMessage) = await sut.fetchCarBrands();

      // Assert
      expect(carBrands, isNull);
      expect(
        errorMessage,
        'Failed to fetch car brands catalog: Exception: $mockExceptionMessage',
      );
    });
  });

  group('fetchCarModelsByBrand Tests |', () {
    test(
        'Should return CarModelsByBrandSuccess when API call succeeds with valid data',
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
      when(
        () => mockClient.get(Uri.parse('$baseUrl/cars/brands/$brandId/models')),
      ).thenAnswer(
        (_) async => Response(mockResponseData, 200),
      );

      // Act
      final (carModels, errorMessage) =
          await sut.fetchCarModelsByBrand(brandId);

      // Assert
      expect(carModels, isA<List<CarSpecModel>>());
      expect(carModels!.length, 5);
    });

    test(
        'Should return CarCatalogFailure when API call fails with a non-200 status code',
        () async {
      // Arrange
      const mockStatusCode = 404;
      final mockMessage = faker.lorem.sentence();
      when(
        () => mockClient.get(Uri.parse('$baseUrl/cars/brands/$brandId/models')),
      ).thenAnswer(
        (_) async => Response(mockMessage, mockStatusCode),
      );

      // Act
      final (carModels, errorMessage) =
          await sut.fetchCarModelsByBrand(brandId);

      // Assert
      expect(carModels, isNull);
      expect(
        errorMessage,
        'Failed to fetch car models catalog. Status code: $mockStatusCode',
      );
    });

    test('Should return CarCatalogFailure when an exception is thrown',
        () async {
      // Arrange
      final mockExceptionMessage = faker.lorem.sentence();
      when(
        () => mockClient.get(Uri.parse('$baseUrl/cars/brands/$brandId/models')),
      ).thenThrow(Exception(mockExceptionMessage));

      // Act
      final (carModels, errorMessage) =
          await sut.fetchCarModelsByBrand(brandId);

      // Assert
      expect(carModels, isNull);
      expect(
        errorMessage,
        'Failed to fetch car models catalog: Exception: $mockExceptionMessage',
      );
    });
  });
}
