import 'dart:developer';

import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/assets_model.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/location_model.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/repositories/i_assets_repository.dart';
import 'package:minicore_arch_example/app/shared/constants/constants.dart';
import 'package:minicore_arch_example/app/shared/errors/i_failure.dart';
import 'package:minicore_arch_example/app/shared/services/http_client/i_http_client.dart';

class AssetsRepository implements IAssetsRepository {
  final IHttpClient httpClient;

  const AssetsRepository(this.httpClient);
  @override
  Future<({List<LocationModel> locationList, String errorMessage})>
      getLocationList(String companyId) async {
    try {
      final response =
          await httpClient.get('$kCompaniesEndpoint/$companyId/locations');
      final locationList = List<Map<String, dynamic>>.from(response.data)
          .map((element) => LocationModel.fromMap(element))
          .toList();
      return (locationList: locationList, errorMessage: '');
    } on IAppFailure catch (e) {
      log(e.toString());
      return (locationList: <LocationModel>[], errorMessage: e.message);
    }
  }

  @override
  Future<({List<AssetsModel> assetsList, String errorMessage})> getAssetsList(
      String companyId) async {
    try {
      final response =
          await httpClient.get('$kCompaniesEndpoint/$companyId/assets');
      final assetsList = List<Map<String, dynamic>>.from(response.data)
          .map((element) => AssetsModel.fromMap(element))
          .toList();
      return (assetsList: assetsList, errorMessage: '');
    } on IAppFailure catch (e) {
      log(e.toString());
      return (assetsList: <AssetsModel>[], errorMessage: e.message);
    }
  }
}
