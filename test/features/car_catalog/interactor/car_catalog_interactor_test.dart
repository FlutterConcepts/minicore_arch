import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchCarBrandsUseCase extends Mock implements FetchCarBrandsUseCase {}

class MockFetchCarModelsByBrandUseCase extends Mock
    implements FetchCarModelsByBrandUseCase {}

void main() {
  late FetchCarBrandsUseCase mockFetchBrandsUseCase;
  late FetchCarModelsByBrandUseCase mockFetchModelsByBrandUseCase;
  late CarCatalogInteractor sut;

  List<CarCatalogState> captureStates(CarCatalogInteractor interactor) {
    final states = <CarCatalogState>[];
    interactor.addListener(() {
      states.add(interactor.value);
    });
    return states;
  }

  setUp(() {
    mockFetchBrandsUseCase = MockFetchCarBrandsUseCase();
    mockFetchModelsByBrandUseCase = MockFetchCarModelsByBrandUseCase();
    sut = CarCatalogInteractor(
      fetchBrandsUseCase: mockFetchBrandsUseCase,
      fetchModelsByBrandUseCase: mockFetchModelsByBrandUseCase,
    );
  });

  group('CarCatalogInteractor Tests', () {
    group('fetchBrands Tests', () {
      test(
          '''Should emit `CarCatalogLoading` followed by `CarBrandsSuccess` when `fetchBrands` completes successfully''',
          () async {
        // Arrange
        when(() => mockFetchBrandsUseCase.call())
            .thenAnswer((_) async => const CarBrandsSuccess([]));
        final states = captureStates(sut);

        // Act
        await sut.fetchBrands();

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarBrandsSuccess>(),
        ]);
        verify(() => mockFetchBrandsUseCase.call()).called(1);
      });

      test(
          '''Should emit `CarCatalogLoading` followed by `CarCatalogFailure` with an appropriate error message when `fetchBrands` fails''',
          () async {
        // Arrange
        final errorMessage = faker.lorem.sentence();
        when(() => mockFetchBrandsUseCase.call())
            .thenAnswer((_) async => CarCatalogFailure(errorMessage));
        final states = captureStates(sut);

        // Act
        await sut.fetchBrands();

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarCatalogFailure>().having(
            (e) => e.message,
            'failure message',
            errorMessage,
          ),
        ]);
        verify(() => mockFetchBrandsUseCase.call()).called(1);
      });
    });

    group('fetchModelsByBrand Tests', () {
      test(
          '''Should emit `CarCatalogLoading` followed by `CarModelsByBrandSuccess` when `fetchModelsByBrand` completes successfully for a given brand ID''',
          () async {
        // Arrange
        const brandId = 1;
        when(() => mockFetchModelsByBrandUseCase.call(brandId))
            .thenAnswer((_) async => const CarModelsByBrandSuccess([]));
        final states = captureStates(sut);

        // Act
        await sut.fetchModelsByBrand(brandId);

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarModelsByBrandSuccess>(),
        ]);
        verify(() => mockFetchModelsByBrandUseCase.call(brandId)).called(1);
      });

      test(
          '''Should emit `CarCatalogLoading` followed by `CarCatalogFailure` with an appropriate error message when `fetchModelsByBrand` fails''',
          () async {
        // Arrange
        const brandId = 1;
        final errorMessage = faker.lorem.sentence();
        when(() => mockFetchModelsByBrandUseCase.call(brandId))
            .thenAnswer((_) async => CarCatalogFailure(errorMessage));
        final states = captureStates(sut);

        // Act
        await sut.fetchModelsByBrand(brandId);

        // Assert
        expect(states, [
          isA<CarCatalogLoading>(),
          isA<CarCatalogFailure>().having(
            (e) => e.message,
            'failure message',
            errorMessage,
          ),
        ]);
        verify(() => mockFetchModelsByBrandUseCase.call(brandId)).called(1);
      });
    });
  });
}
