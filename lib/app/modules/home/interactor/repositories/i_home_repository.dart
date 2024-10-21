import 'package:minicore_arch_example/app/modules/home/interactor/models/company_model.dart';

mixin IHomeRepository {
  Future<(List<CompanyModel> companyList, String errorMessage)> getCompanyList();
}
