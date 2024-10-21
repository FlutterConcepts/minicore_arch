import 'dart:developer';

import 'package:minicore_arch_example/app/modules/home/interactor/models/company_model.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/i_home_repository.dart';
import 'package:minicore_arch_example/app/shared/constants/constants.dart';
import 'package:minicore_arch_example/app/shared/errors/i_failure.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/i_http_client.dart';

class HomeRepository implements IHomeRepository {
  final IHttpClient httpClient;

  HomeRepository(this.httpClient);
  @override
  Future<({List<CompanyModel> companiesList, String errorMessage})> getCompaniesList() async {
    try {
      final response = await httpClient.get(kCompaniesEndpoint);
      final companiesList =
          List<Map<String, dynamic>>.from(response.data).map((element) => CompanyModel.fromMap(element)).toList();
      return (companiesList: companiesList, errorMessage: '');
    } on IAppFailure catch (e) {
      log(e.toString());
      return (companiesList: <CompanyModel>[], errorMessage: e.message);
    }
  }
}
