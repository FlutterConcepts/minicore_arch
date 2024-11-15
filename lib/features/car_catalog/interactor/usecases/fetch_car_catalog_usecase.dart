// ignore_for_file: one_member_abstracts
import 'package:minicore_arch_example/features/car_catalog/interactor/car_catalog_states.dart';

abstract interface class FetchCarCatalogUseCase {
  Future<CarCatalogState> call();
}
