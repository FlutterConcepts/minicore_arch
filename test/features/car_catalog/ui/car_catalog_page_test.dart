import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_interactor.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_states.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/usecases/fetch_car_catalog_usecase.dart';
import 'package:minicore_arch_example/features/car_catalog/ui/car_catalog_page.dart';
import 'package:minicore_arch_example/features/car_catalog/ui/car_catalog_provider.dart';

class CarInteractorMock extends ValueNotifier<CarCatalogState>
    implements CarCatalogInteractor {
  CarInteractorMock() : super(CarCatalogLoading());

  @override
  FetchCarCatalogUseCase get fetchUseCase => throw UnimplementedError();

  @override
  Future<void> fetch() async {}
}

void main() {
  group('CarCatalogPage Tests', () {
    late CarInteractorMock interactor;

    setUp(() {
      // Arrange
      interactor = CarInteractorMock();
    });

    testWidgets('Should correctly display the page states', (tester) async {
      // Act
      await tester.pumpWidget(
        CarCatalogProvider(
          interactor: interactor,
          child: const MaterialApp(
            home: CarCatalogPage(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);
      expect(find.byKey(const Key('CarCatalogSuccess')), findsNothing);

      // Arrange
      interactor.value = const CarCatalogSuccess([]);

      // Act
      await tester.pump();

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
      expect(find.byKey(const Key('CarCatalogSuccess')), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);

      // Arrange
      final String errorMessage = faker.lorem.sentence();
      interactor.value = CarCatalogFailure(errorMessage);

      // Act
      await tester.pump();

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
      expect(find.byKey(const Key('CarCatalogSuccess')), findsNothing);
      expect(find.byKey(const Key('CarCatalogFailure')), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}
