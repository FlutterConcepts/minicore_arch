import 'package:asp/asp.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/assets_model.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/location_model.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/node_entity.dart';

class AssetsSA {
  static final assetsListStateAtom = Atom<List<AssetsModel>>([]);
  static final locationsListStateAtom = Atom<List<LocationModel>>([]);
  static final nodesListComputedStateAtom = Atom<List<NodeEntity>>([]);
  static final nodesFilteredListComputedStateAtom = Atom<List<NodeEntity>>([]);
  static final isLoadingStateAtom = Atom<bool>(false);
  static final errorMessageStateAtom = Atom<String>('');
}
