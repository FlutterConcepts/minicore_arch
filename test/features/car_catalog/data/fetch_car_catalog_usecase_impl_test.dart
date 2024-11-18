import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late FetchCarCatalogUseCaseImpl sut;

  setUp(() {
    // Arrange
    mockHttpClient = MockHttpClient();
    sut = FetchCarCatalogUseCaseImpl(mockHttpClient);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  group('FetchCarCatalogUseCase', () {
    test(
        'should return CarCatalogSuccess when API call succeeds with valid data',
        () async {
      // Arrange
      final mockResponseData = jsonEncode(
        List.generate(5, (_) {
          return {
            'codigo': faker.guid.guid(),
            'nome': faker.vehicle.model(),
          };
        }),
      );
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => Response(mockResponseData, 200),
      );

      // Act
      final result = await sut.call();

      // Assert
      expect(result, isA<CarCatalogSuccess>());
      final successState = result as CarCatalogSuccess;
      expect(successState.carCatalog.length, 5);
      expect(successState.carCatalog[0], isA<CarEntity>());
    });

    test(
        'should return CarCatalogFailure when API call fails with a non-200 status code',
        () async {
      // Arrange
      const mockStatusCode = 404;
      final mockMessage = faker.lorem.sentence();
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => Response(mockMessage, mockStatusCode),
      );

      // Act
      final result = await sut.call();

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(
        failureState.message,
        'Failed to fetch car catalog. Status code: $mockStatusCode',
      );
    });

    test('should return CarCatalogFailure when an exception is thrown',
        () async {
      // Arrange
      final mockExceptionMessage = faker.lorem.sentence();
      when(() => mockHttpClient.get(any()))
          .thenThrow(Exception(mockExceptionMessage));

      // Act
      final result = await sut.call();

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(
        failureState.message,
        'Failed to fetch car catalog: Exception: $mockExceptionMessage',
      );
    });
  });
}
