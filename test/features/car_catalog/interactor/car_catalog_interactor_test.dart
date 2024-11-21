import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchCarBrandsUseCase extends Mock implements FetchCarBrandsUseCase {}

class MockFetchCarModelsByBrandUseCase extends Mock
    implements FetchCarModelsByBrandUseCase {}

void main() {
  late FetchCarBrandsUseCase mockFetchCarBrandsUseCase;
  late FetchCarModelsByBrandUseCase mockFetchCarModelsByBrandUseCase;
  late CarCatalogInteractor sut;

  List<CarCatalogState> captureStates(CarCatalogInteractor interactor) {
    final states = <CarCatalogState>[];
    interactor.addListener(() {
      states.add(interactor.value);
    });
    return states;
  }

  setUp(() {
    mockFetchCarBrandsUseCase = MockFetchCarBrandsUseCase();
    mockFetchCarModelsByBrandUseCase = MockFetchCarModelsByBrandUseCase();
    sut = CarCatalogInteractor(
      fetchCarBrandsUseCase: mockFetchCarBrandsUseCase,
      fetchCarModelsByBrandUseCase: mockFetchCarModelsByBrandUseCase,
    );
  });

  group('CarCatalogInteractor Tests', () {
    group('fetchCarBrands Tests', () {
      test(
          '''Should emit `CarCatalogLoading` followed by `CarBrandsSuccess` when `fetchCarBrands` completes successfully''',
          () async {
        // Arrange
        when(() => mockFetchCarBrandsUseCase.call(null))
            .thenAnswer((_) async => const CarBrandsSuccess([]));
        final states = captureStates(sut);

        // Act
        await sut.fetchCarBrands();

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarBrandsSuccess>(),
        ]);
        verify(() => mockFetchCarBrandsUseCase.call(null)).called(1);
      });

      test(
          '''Should emit `CarCatalogLoading` followed by `CarCatalogFailure` with an appropriate error message when `fetchCarBrands` fails''',
          () async {
        // Arrange
        final errorMessage = faker.lorem.sentence();
        when(() => mockFetchCarBrandsUseCase.call(null))
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
        verify(() => mockFetchCarBrandsUseCase.call(null)).called(1);
      });
    });

    group('fetchCarModelsByBrand Tests', () {
      test(
          '''Should emit `CarCatalogLoading` followed by `CarModelsByBrandSuccess` when `fetchCarModelsByBrand` completes successfully for a given brand ID''',
          () async {
        // Arrange
        const brandId = 1;
        when(() => mockFetchCarModelsByBrandUseCase.call(brandId))
            .thenAnswer((_) async => const CarModelsByBrandSuccess([]));
        final states = captureStates(sut);

        // Act
        await sut.fetchCarModelsByBrand(brandId);

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarModelsByBrandSuccess>(),
        ]);
        verify(() => mockFetchCarModelsByBrandUseCase.call(brandId)).called(1);
      });

      test(
          '''Should emit `CarCatalogLoading` followed by `CarCatalogFailure` with an appropriate error message when `fetchCarModelsByBrand` fails''',
          () async {
        // Arrange
        const brandId = 1;
        final errorMessage = faker.lorem.sentence();
        when(() => mockFetchCarModelsByBrandUseCase.call(brandId))
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
        verify(() => mockFetchCarModelsByBrandUseCase.call(brandId)).called(1);
      });
    });
  });
}
