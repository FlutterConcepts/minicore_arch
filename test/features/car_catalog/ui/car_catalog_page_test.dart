import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/minicore_arch_example.dart';

class MockCarInteractor extends ValueNotifier<CarCatalogState>
    implements CarCatalogInteractor {
  MockCarInteractor() : super(CarCatalogLoading());

  @override
  FetchCarBrandsUseCase get fetchBrands => throw UnimplementedError();

  @override
  Future<void> fetch() async {}
}

void main() {
  group('CarCatalogPage Tests', () {
    late MockCarInteractor mockInteractor;

    setUp(() {
      mockInteractor = MockCarInteractor();
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
      expect(find.byKey(const Key('CarCatalogSuccess')), findsNothing);

      // Arrange
      mockInteractor.value = const CarCatalogSuccess([]);

      // Act
      await tester.pump();

      // Assert
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
      expect(find.byKey(const Key('CarCatalogSuccess')), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);

      // Arrange
      final errorMessage = faker.lorem.sentence();
      mockInteractor.value = CarCatalogFailure(errorMessage);

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
