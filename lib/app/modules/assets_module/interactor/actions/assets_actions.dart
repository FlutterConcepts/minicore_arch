import 'package:minicore_arch_example/app/injector.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/atoms/assets_state_atoms.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/node_entity.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/repositories/assets_repository.dart';

Future<void> getAssetsListAction(String companyId) async {
  final repository = injector.get<AssetsRepository>();
  AssetsSA.isLoadingStateAtom.value = true;
  final (:assetsList, :errorMessage) = await repository.getAssetsList(companyId);
  AssetsSA.assetsListStateAtom.value = assetsList;
  AssetsSA.errorMessageStateAtom.value = errorMessage;
  AssetsSA.isLoadingStateAtom.value = false;
}

Future<void> getLocationListAction(String companyId) async {
  final repository = injector.get<AssetsRepository>();
  AssetsSA.isLoadingStateAtom.value = true;
  final (:locationList, :errorMessage) = await repository.getLocationList(companyId);
  AssetsSA.locationsListStateAtom.value = locationList;
  AssetsSA.errorMessageStateAtom.value = errorMessage;
  AssetsSA.isLoadingStateAtom.value = false;
}

void computeListAction() {
  final Map<String, List<NodeEntity>> childrenMap = {};
  final Set<String> assignedChildIds = {};

  final Map<String, NodeEntity> nodeById = {};

  for (final node in [...AssetsSA.locationsListStateAtom.value, ...AssetsSA.assetsListStateAtom.value]) {
    nodeById[node.id] = node;
    childrenMap.putIfAbsent(node.id, () => []);

    if (nodeById.containsKey(node.parentId)) {
      childrenMap[node.parentId]!.add(node);
      assignedChildIds.add(node.id);
    } else if (nodeById.containsKey(node.locationId)) {
      childrenMap[node.locationId]!.add(node);
      assignedChildIds.add(node.id);
    }

    node.children = childrenMap[node.id] ?? [];
  }

  AssetsSA.nodesListComputedStateAtom.value = [
    ...AssetsSA.locationsListStateAtom.value,
    ...AssetsSA.assetsListStateAtom.value
  ].where((node) => node.parentId == null && node.locationId == null || !assignedChildIds.contains(node.id)).toList();

  sortByChildren();

  AssetsSA.nodesFilteredListComputedStateAtom.value = AssetsSA.nodesListComputedStateAtom.value;
}

void sortByChildren() {
  AssetsSA.nodesListComputedStateAtom.value.sort((a, b) {
    final bool aHasChildren = a.children.isNotEmpty;
    final bool bHasChildren = b.children.isNotEmpty;

    if (aHasChildren && !bHasChildren) {
      return -1;
    } else if (!aHasChildren && bHasChildren) {
      return 1;
    } else {
      return 0;
    }
  });
}

void filterListFromText(String filter) {
  AssetsSA.nodesListComputedStateAtom.value = [
    ...AssetsSA.locationsListStateAtom.value,
    ...AssetsSA.assetsListStateAtom.value,
  ];
  if (filter.isEmpty) {
    AssetsSA.nodesFilteredListComputedStateAtom.value = AssetsSA.nodesListComputedStateAtom.value;
    return;
  }
  final list = AssetsSA.nodesListComputedStateAtom.value
      .where((e) => e.name.toLowerCase().trim().contains(filter.toLowerCase().trim()))
      .toList();
  AssetsSA.nodesFilteredListComputedStateAtom.value = list;
}

void filterListFromEnergySensors() {
  final list = AssetsSA.assetsListStateAtom.value.where((e) => e.sensorType.toLowerCase().contains('energy')).toList();
  AssetsSA.nodesFilteredListComputedStateAtom.value = list;
}

void filterListFromCriticalAlert() {
  final list = AssetsSA.assetsListStateAtom.value.where((e) => e.status.toLowerCase().contains('alert')).toList();
  AssetsSA.nodesFilteredListComputedStateAtom.value = list;
}
