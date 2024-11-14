import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/assets_model.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/location_model.dart';

abstract class AssetsRepository {
  Future<({List<LocationModel> locationList, String errorMessage})> getLocationList(String companyId);
  Future<({List<AssetsModel> assetsList, String errorMessage})> getAssetsList(String companyId);
}
