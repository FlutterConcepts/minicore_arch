import 'dart:developer';

import 'package:minicore_arch_example/app/modules/home/interactor/models/company_model.dart';
import 'package:minicore_arch_example/app/modules/home/interactor/repositories/home_repository.dart';
import 'package:minicore_arch_example/app/shared/errors/i_failure.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/http_client.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/http_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HttpClient httpClient;

  HomeRepositoryImpl(this.httpClient);
  @override
  Future<({List<CompanyModel> companiesList, String errorMessage})> getCompaniesList() async {
    try {
      // TODO(Kevin): put it back
      // final response = await httpClient.get(kCompaniesEndpoint);

      // TODO(Kevin): remove this mock
      const dynamic responseJson = [
        {'id': '662fd0ee639069143a8fc387', 'name': 'Jaguar'},
        {'id': '662fd0fab3fd5656edb39af5', 'name': 'Tobias'},
        {'id': '662fd100f990557384756e58', 'name': 'Apex'}
      ];
      const response = HttpResponse(
        statusCode: 200,
        data: responseJson,
      );

      final companiesList =
          List<Map<String, dynamic>>.from(response.data).map((element) => CompanyModel.fromMap(element)).toList();

      return (companiesList: companiesList, errorMessage: '');
    } on IAppFailure catch (e) {
      log(e.toString());
      return (companiesList: <CompanyModel>[], errorMessage: e.message);
    }
  }
}
