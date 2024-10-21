import 'package:asp/asp.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/models/company_model.dart';

final companiesListState = Atom<List<CompanyModel>>([]);
final isLoadingState = Atom<bool>(false);
final errorMessageState = Atom<String>('');
