import 'package:minicore_arch_example/app/injector.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/atoms/home_state_atoms.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/home_repository.dart';

Future<void> getCompaniesListAction() async {
  final repository = injector.get<HomeRepository>();
  HomeSA.isLoadingState.value = true;
  final (:companiesList, :errorMessage) = await repository.getCompaniesList();
  HomeSA.companiesListState.value = companiesList;
  HomeSA.errorMessageState.value = errorMessage;
  HomeSA.isLoadingState.value = false;
}
