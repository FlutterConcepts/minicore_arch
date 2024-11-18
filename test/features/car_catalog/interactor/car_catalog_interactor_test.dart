import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';
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
    sut = CarCatalogInteractor(mockFetchUseCase);
  });

  group('CarCatalogInteractor Tests', () {
    test('Should emit loading and success states when fetching succeeds',
        () async {
      // Arrange
      when(() => mockFetchUseCase.call())
          .thenAnswer((_) async => const CarCatalogSuccess([]));
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
      final errorMessage = faker.lorem.sentence();
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
          errorMessage,
        ),
      ]);
      verify(() => mockFetchUseCase.call()).called(1);
    });
  });
}
