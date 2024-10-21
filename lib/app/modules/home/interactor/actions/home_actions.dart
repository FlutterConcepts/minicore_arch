import 'package:minicore_arch_example/app/injector.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/atoms/home_atom.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/i_home_repository.dart';

Future<void> getCompaniesListAction() async {
  final repository = injector.get<IHomeRepository>();
  isLoadingState.value = true;
  final (:companiesList, :errorMessage) = await repository.getCompaniesList();
  companiesListState.value = companiesList;
  errorMessageState.value = errorMessage;
  isLoadingState.value = false;
}
