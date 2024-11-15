// ignore_for_file: one_member_abstracts
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_state.dart';

abstract interface class LoadCarCatalogUseCase {
  Future<CarCatalogState> call();
}
