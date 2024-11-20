import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class MockCarCatalogInteractor extends ValueNotifier<CarCatalogState>
    implements CarCatalogInteractor {
  MockCarCatalogInteractor() : super(CarCatalogLoading());

  @override
  CarCatalogRepository get repository => throw UnimplementedError();

  @override
  Future<void> fetchCarBrands() async {}
  @override
  Future<void> fetchCarModelsByBrand(int brandId) async {}
}

void main() {
  group('CarCatalogPage Tests |', () {
    late CarCatalogInteractor mockInteractor;

    setUp(() {
      mockInteractor = MockCarCatalogInteractor();
    });

    testWidgets('Should correctly display the page states', (tester) async {
      // Act
      await tester.pumpWidget(
        CarCatalogProvider(
          interactor: mockInteractor,
          child: const MaterialApp(
            home: CarCatalogPage(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);
      expect(find.byKey(const Key('CarBrandsSuccess')), findsNothing);
      expect(find.byKey(const Key('CarModelsByBrandSuccess')), findsNothing);

      // Arrange
      mockInteractor.value = const CarBrandsSuccess([]);

      // Act
      await tester.pump();

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
      expect(find.byKey(const Key('CarBrandsSuccess')), findsOneWidget);
      expect(find.byKey(const Key('CarModelsByBrandSuccess')), findsNothing);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);

      // Arrange
      mockInteractor.value = const CarModelsByBrandSuccess([]);

      // Act
      await tester.pump();

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
      expect(find.byKey(const Key('CarBrandsSuccess')), findsNothing);
      expect(find.byKey(const Key('CarModelsByBrandSuccess')), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);

      // Arrange
      final errorMessage = faker.lorem.sentence();
      mockInteractor.value = CarCatalogFailure(errorMessage);

      // Act
      await tester.pump();

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
      expect(find.byKey(const Key('CarBrandsSuccess')), findsNothing);
      expect(find.byKey(const Key('CarModelsByBrandSuccess')), findsNothing);
      expect(find.byKey(const Key('CarCatalogFailure')), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}
