import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_interactor.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_state.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/usecases/fetch_car_catalog_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchCarCatalogUseCase extends Mock
    implements FetchCarCatalogUseCase {}

void main() {
  late FetchCarCatalogUseCase mockFetchUseCase;
  late CarCatalogInteractor sut;

  setUp(() {
    mockFetchUseCase = MockFetchCarCatalogUseCase();
    sut = CarCatalogInteractor(fetchUseCase: mockFetchUseCase);
  });

  test('Process fetch car catalog with success', () async {
    // Arrange
    when(() => mockFetchUseCase.call())
        .thenAnswer((_) async => const CarCatalogSuccess(carCatalog: []));
    final states = <CarCatalogState>[];
    sut.addListener(() {
      states.add(sut.value);
    });

    // Act
    await sut.fetch();

    // Assert
    expect(states, [
      isA<CarCatalogLoading>(),
      isA<CarCatalogSuccess>(),
    ]);

    verify(() => mockFetchUseCase.call()).called(1);
  });

  test('Process fetch cars with failure', () async {
    // Arrange
    when(() => mockFetchUseCase.call())
        .thenAnswer((_) async => const CarCatalogFailure('falha'));

    final states = <CarCatalogState>[];
    sut.addListener(() {
      states.add(sut.value);
    });

    // Act
    await sut.fetch();

    // Assert
    expect(states, [
      isA<CarCatalogLoading>(),
      isA<CarCatalogFailure>(),
    ]);

    verify(() => mockFetchUseCase.call()).called(1);
  });
}
