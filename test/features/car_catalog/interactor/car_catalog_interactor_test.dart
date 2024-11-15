import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_interactor.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_states.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/usecases/fetch_car_catalog_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchCarCatalogUseCase extends Mock
    implements FetchCarCatalogUseCase {}

void main() {
  late FetchCarCatalogUseCase mockFetchUseCase;
  late CarCatalogInteractor sut;

  List<CarCatalogState> captureStates(CarCatalogInteractor interactor) {
    final states = <CarCatalogState>[];
    interactor.addListener(() {
      states.add(interactor.value);
    });
    return states;
  }

  setUp(() {
    // Arrange
    mockFetchUseCase = MockFetchCarCatalogUseCase();
    sut = CarCatalogInteractor(fetchUseCase: mockFetchUseCase);
  });

  group('CarCatalogInteractor Tests', () {
    test('Should emit loading and success states when fetching succeeds',
        () async {
      // Arrange
      when(() => mockFetchUseCase.call())
          .thenAnswer((_) async => const CarCatalogSuccess(carCatalog: []));
      final states = captureStates(sut);

      // Act
      await sut.fetch();

      // Assert
      expect(states, [
        isA<CarCatalogLoading>(),
        isA<CarCatalogSuccess>(),
      ]);
      verify(() => mockFetchUseCase.call()).called(1);
    });

    test('Should emit loading and failure states when fetching fails',
        () async {
      // Arrange
      final String errorMessage = faker.lorem.sentence();
      when(() => mockFetchUseCase.call())
          .thenAnswer((_) async => CarCatalogFailure(errorMessage));
      final states = captureStates(sut);

      // Act
      await sut.fetch();

      // Assert
      expect(states, [
        isA<CarCatalogLoading>(),
        isA<CarCatalogFailure>().having(
            (e) => e.message, // Corrige o acesso à mensagem
            'failure message',
            errorMessage),
      ]);
      verify(() => mockFetchUseCase.call()).called(1);
    });
  });
}
