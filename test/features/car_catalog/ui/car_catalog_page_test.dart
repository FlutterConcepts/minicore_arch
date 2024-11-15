import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_interactor.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_state.dart';
import 'package:minicore_arch_example/features/car_catalog/interactor/usecases/fetch_car_catalog_usecase.dart';
import 'package:minicore_arch_example/features/car_catalog/ui/car_catalog_page.dart';
import 'package:minicore_arch_example/features/car_catalog/ui/car_catalog_provider.dart';

class CarInteractorMock extends ValueNotifier<CarCatalogState>
    implements CarCatalogInteractor {
  CarInteractorMock() : super(CarCatalogLoading());

  @override
  FetchCarCatalogUseCase get fetchUseCase => throw UnimplementedError();

  @override
  void fetch() {}
}

void main() {
  group('CarCatalogPage Tests', () {
    late CarInteractorMock interactor;

    setUp(() {
      interactor = CarInteractorMock();
    });

    testWidgets('Deve exibir corretamente os estados da página',
        (tester) async {
      await tester.pumpWidget(
        CarCatalogProvider(
          interactor: interactor,
          child: const MaterialApp(
            home: CarCatalogPage(),
          ),
        ),
      );

      expect(find.byKey(const Key('CarCatalogLoading')), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);
      expect(find.byKey(const Key('CarCatalogSuccess')), findsNothing);

      interactor.value = const CarCatalogSuccess(carCatalog: []);
      await tester.pump();

      expect(find.byKey(const Key('CarCatalogSuccess')), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
      expect(find.byKey(const Key('CarCatalogFailure')), findsNothing);

      interactor.value = const CarCatalogFailure('falha');
      await tester.pump();

      expect(find.byKey(const Key('CarCatalogFailure')), findsOneWidget);
      expect(find.text('falha'), findsOneWidget);
      expect(find.byKey(const Key('CarCatalogSuccess')), findsNothing);
      expect(find.byKey(const Key('CarCatalogLoading')), findsNothing);
    });
  });
}
