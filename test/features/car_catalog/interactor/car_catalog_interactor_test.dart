import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockCarCatalogRepository extends Mock implements CarCatalogRepository {}

void main() {
  late CarCatalogRepository mockRepository;
  late CarCatalogInteractor sut;

  List<CarCatalogState> captureStates(CarCatalogInteractor interactor) {
    final states = <CarCatalogState>[];
    interactor.addListener(() {
      states.add(interactor.value);
    });
    return states;
  }

  setUp(() {
    mockRepository = MockCarCatalogRepository();
    sut = CarCatalogInteractor(mockRepository);
  });

  group('CarCatalogInteractor Tests |', () {
    group('fetchCarBrands Tests', () {
      test(
          'Should emit `CarCatalogLoading` followed by `CarBrandsSuccess` when `fetchCarBrands` completes successfully',
          () async {
        // Arrange
        when(mockRepository.fetchCarBrands)
            .thenAnswer((_) async => const CarBrandsSuccess([]));
        final states = captureStates(sut);

        // Act
        await sut.fetchCarBrands();

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarBrandsSuccess>(),
        ]);
        verify(mockRepository.fetchCarBrands).called(1);
      });

      test(
          'Should emit `CarCatalogLoading` followed by `CarCatalogFailure` with an appropriate error message when `fetchCarBrands` fails',
          () async {
        // Arrange
        final errorMessage = faker.lorem.sentence();
        when(mockRepository.fetchCarBrands)
            .thenAnswer((_) async => CarCatalogFailure(errorMessage));
        final states = captureStates(sut);

        // Act
        await sut.fetchCarBrands();

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarCatalogFailure>().having(
            (e) => e.message,
            'failure message',
            errorMessage,
          ),
        ]);
        verify(mockRepository.fetchCarBrands).called(1);
      });
    });

    group('fetchModelsByBrand Tests |', () {
      test(
          'Should emit `CarCatalogLoading` followed by `CarModelsByBrandSuccess` when `fetchModelsByBrand` completes successfully for a given brand ID',
          () async {
        // Arrange
        const brandId = 1;
        when(() => mockRepository.fetchCarModelsByBrand(brandId))
            .thenAnswer((_) async => const CarModelsByBrandSuccess([]));
        final states = captureStates(sut);

        // Act
        await sut.fetchCarModelsByBrand(brandId);

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarModelsByBrandSuccess>()
              .having((e) => e.carModels, 'carModels length', hasLength(0)),
        ]);
        verify(() => mockRepository.fetchCarModelsByBrand(brandId)).called(1);
      });

      test(
          'Should emit `CarCatalogLoading` followed by `CarCatalogFailure` with an appropriate error message when `fetchModelsByBrand` fails',
          () async {
        // Arrange
        const brandId = 1;
        final errorMessage = faker.lorem.sentence();
        when(() => mockRepository.fetchCarModelsByBrand(brandId))
            .thenAnswer((_) async => CarCatalogFailure(errorMessage));
        final states = captureStates(sut);

        // Act
        await sut.fetchCarModelsByBrand(brandId);

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarCatalogFailure>().having(
            (e) => e.message,
            'failure message',
            errorMessage,
          ),
        ]);
        verify(() => mockRepository.fetchCarModelsByBrand(brandId)).called(1);
      });
    });
  });
}
