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
    test('Should emit loading and success states when fetching succeeds',
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

    test('Should emit loading and failure states when fetching fails',
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
          (e) => e.message, // Corrige o acesso à mensagem
          'failure message',
          errorMessage,
        ),
      ]);
      verify(() => mockFetchBrandsUseCase.call()).called(1);
    });
  });
}
