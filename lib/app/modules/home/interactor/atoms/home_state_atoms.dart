import 'package:asp/asp.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/models/company_model.dart';

class HomeSA {
  static final companiesListState = Atom<List<CompanyModel>>([]);
  static final isLoadingState = Atom<bool>(false);
  static final errorMessageState = Atom<String>('');
}
