// ignore_for_file: one_member_abstracts, public_member_api_docs

import 'package:minicore_arch_example/minicore_arch_example.dart';

abstract interface class FetchCarCatalogUseCase {
  Future<CarCatalogState> call();
}
