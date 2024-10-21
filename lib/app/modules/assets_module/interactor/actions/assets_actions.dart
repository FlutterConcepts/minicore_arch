import 'package:minicore_arch_example/app/injector.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/atoms/assets_atoms.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/node_entity.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/repositories/i_assets_repository.dart';

Future<void> getAssetsListAction(String companyId) async {
  final repository = injector.get<IAssetsRepository>();
  isLoadingState.value = true;
  final (:assetsList, :errorMessage) = await repository.getAssetsList(companyId);
  assetsListState.value = assetsList;
  errorMessageState.value = errorMessage;
  isLoadingState.value = false;
}

Future<void> getLocationListAction(String companyId) async {
  final repository = injector.get<IAssetsRepository>();
  isLoadingState.value = true;
  final (:locationList, :errorMessage) = await repository.getLocationList(companyId);
  locationsListState.value = locationList;
  errorMessageState.value = errorMessage;
  isLoadingState.value = false;
}

void computeListAction() {
  final Map<String, List<NodeEntity>> childrenMap = {};
  final Set<String> assignedChildIds = {};

  final Map<String, NodeEntity> nodeById = {};

  for (final node in [...locationsListState.value, ...assetsListState.value]) {
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

  nodesComputedListState.value = [...locationsListState.value, ...assetsListState.value]
      .where((node) => node.parentId == null && node.locationId == null || !assignedChildIds.contains(node.id))
      .toList();

  sortByChildren();

  nodesComputedListStateFiltered.value = nodesComputedListState.value;
}

void sortByChildren() {
  nodesComputedListState.value.sort((a, b) {
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
  nodesComputedListState.value = [
    ...locationsListState.value,
    ...assetsListState.value,
  ];
  if (filter.isEmpty) {
    nodesComputedListStateFiltered.value = nodesComputedListState.value;
    return;
  }
  final list =
      nodesComputedListState.value.where((e) => e.name.toLowerCase().trim().contains(filter.toLowerCase().trim()));
  nodesComputedListStateFiltered.value = list.toList();
}

void filterListFromEnergySensors() {
  final list = assetsListState.value.where((e) => e.sensorType.toLowerCase().contains('energy'));
  nodesComputedListStateFiltered.value = list.toList();
}

void filterListFromCriticalAlert() {
  final list = assetsListState.value.where((e) => e.status.toLowerCase().contains('alert'));
  nodesComputedListStateFiltered.value = list.toList();
}
