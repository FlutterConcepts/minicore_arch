import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockParallelumCarCatalogRepository extends Mock
    implements ParallelumCarCatalogRepository {}

void main() {
  late ParallelumCarCatalogRepository mockMockParallelumCarCatalogRepository;
  late FetchCarBrandsUseCaseImpl sut;

  setUp(() {
    mockMockParallelumCarCatalogRepository =
        MockParallelumCarCatalogRepository();
    sut = FetchCarBrandsUseCaseImpl(
      mockMockParallelumCarCatalogRepository,
    );
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  group('FetchCarBrandsUseCase |', () {
    test(
        'Should return CarBrandsSuccess when API call succeeds with valid data',
        () async {
      // Arrange
      final mockCarBrands = List.generate(5, (_) {
        return CarBrandModel(
          code: faker.randomGenerator.integer(1000, min: 1),
          name: faker.vehicle.model(),
        );
      });
      when(() => mockMockParallelumCarCatalogRepository.fetchCarBrands())
          .thenAnswer(
        (_) async => (mockCarBrands, null),
      );

      // Act
      final result = await sut.call(null);

      // Assert
      expect(result, isA<CarBrandsSuccess>());
      final successState = result as CarBrandsSuccess;
      expect(successState.carBrands.length, 5);
    });

    test(
        'Should return CarCatalogFailure when API call fails with a non-200 status code',
        () async {
      // Arrange
      final mockMessage = faker.lorem.sentence();
      when(() => mockMockParallelumCarCatalogRepository.fetchCarBrands())
          .thenAnswer(
        (_) async => (null, mockMessage),
      );

      // Act
      final result = await sut.call(null);

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
      when(() => mockMockParallelumCarCatalogRepository.fetchCarBrands())
          .thenThrow(
        Exception(mockExceptionMessage),
      );

      // Act
      final result = await sut.call(null);

      // Assert
      expect(
        result,
        isA<CarCatalogFailure>().having(
          (e) => e.message,
          'message',
          equals(
            'Failed to fetch car brands catalog: Exception: $mockExceptionMessage',
          ),
        ),
      );
    });
  });
}
