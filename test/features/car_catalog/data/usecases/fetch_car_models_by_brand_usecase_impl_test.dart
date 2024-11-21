import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockParallelumCarCatalogRepository extends Mock
    implements ParallelumCarCatalogRepository {}

void main() {
  const brandId = 1;
  late ParallelumCarCatalogRepository mockMockParallelumCarCatalogRepository;
  late FetchCarModelsByBrandUseCaseImpl sut;

  setUp(() {
    mockMockParallelumCarCatalogRepository =
        MockParallelumCarCatalogRepository();
    sut = FetchCarModelsByBrandUseCaseImpl(
      mockMockParallelumCarCatalogRepository,
    );
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  group('FetchCarModelsByBrandUseCase |', () {
    test(
        'Should return CarModelsByBrandSuccess when API call succeeds with valid data',
        () async {
      // Arrange
      final mockCarSpecs = List.generate(5, (_) {
        return CarSpecModel(
          code: faker.randomGenerator.integer(1000, min: 1),
          name: faker.vehicle.model(),
        );
      });
      when(
        () => mockMockParallelumCarCatalogRepository
            .fetchCarModelsByBrand(brandId),
      ).thenAnswer(
        (_) async => (mockCarSpecs, null),
      );

      // Act
      final result = await sut.call(brandId);

      // Assert
      expect(result, isA<CarModelsByBrandSuccess>());
      final successState = result as CarModelsByBrandSuccess;
      expect(successState.carSpecs.length, 5);
    });

    test(
        'Should return CarCatalogFailure when API call fails with a non-200 status code',
        () async {
      // Arrange
      final mockMessage = faker.lorem.sentence();
      when(
        () => mockMockParallelumCarCatalogRepository
            .fetchCarModelsByBrand(brandId),
      ).thenAnswer(
        (_) async => (null, mockMessage),
      );

      // Act
      final result = await sut.call(brandId);

      // Assert
      expect(result, isA<CarCatalogFailure>());
      final failureState = result as CarCatalogFailure;
      expect(
        failureState.message,
        mockMessage,
      );
    });

    test('should return CarCatalogFailure when an exception is thrown',
        () async {
      // Arrange
      final mockExceptionMessage = faker.lorem.sentence();
      when(
        () => mockMockParallelumCarCatalogRepository
            .fetchCarModelsByBrand(brandId),
      ).thenThrow(
        Exception(mockExceptionMessage),
      );

      // Act
      final result = await sut.call(brandId);

      // Assert
      expect(
        result,
        isA<CarCatalogFailure>().having(
          (e) => e.message,
          'message',
          equals(
            'Failed to fetch car models catalog: Exception: $mockExceptionMessage',
          ),
        ),
      );
    });
  });
}
