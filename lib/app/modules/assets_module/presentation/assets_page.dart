import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/actions/assets_actions.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/atoms/assets_state_atoms.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/node_entity.dart';
import 'package:minicore_arch_example/app/modules/assets_module/presentation/widgets/expansible_list_tile.dart';
import 'package:minicore_arch_example/app/shared/widgets/buttons/Selectable_buttons.dart';
import 'package:minicore_arch_example/app/shared/widgets/buttons/custom_toggle_button.dart';
import 'package:minicore_arch_example/app/shared/widgets/text_input/custom_search_field.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({required this.companyId, super.key});
  final String companyId;

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  void initState() {
    super.initState();
    unawaited(getAssetsListAction(widget.companyId).whenComplete(() {
      getLocationListAction(widget.companyId).whenComplete(() {
        computeListAction();
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    context.select(() => [
          // TODO(Kevin): verify why these two atoms are or are not necessary
          // assetsListStateAtom,
          // locationsListStateAtom,
          AssetsSA.nodesListComputedStateAtom,
          AssetsSA.nodesFilteredListComputedStateAtom,
          AssetsSA.isLoadingStateAtom,
          AssetsSA.errorMessageStateAtom,
        ]);

    final List<NodeEntity> nodesList = AssetsSA.nodesFilteredListComputedStateAtom.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assets',
          style: textTheme.headlineMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSearchField(
              hintText: 'Buscar Ativo ou Local',
              onChanged: (value) {
                filterListFromText(value);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: SelectableButtons(
                onUnselectAll: computeListAction,
                children: [
                  CustomToggleButton(
                    icon: CupertinoIcons.bolt,
                    text: 'Sensor de Energia',
                    onPressed: filterListFromEnergySensors,
                  ),
                  CustomToggleButton(
                    icon: Icons.error_outline,
                    text: 'Crítico',
                    onPressed: filterListFromCriticalAlert,
                  ),
                ],
              ),
            ),
            if (AssetsSA.isLoadingStateAtom.value)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            else if (AssetsSA.errorMessageStateAtom.value.isNotEmpty)
              Center(
                child: Text(AssetsSA.errorMessageStateAtom.value),
              )
            else if (nodesList.isEmpty)
              const Center(
                child: Text('Assets not found'),
              )
            else
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final node = AssetsSA.nodesFilteredListComputedStateAtom.value[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ExpansibleListTile(
                              item: node,
                              listNodes: AssetsSA.nodesListComputedStateAtom.value,
                            ),
                          );
                        },
                        childCount: AssetsSA.nodesFilteredListComputedStateAtom.value.length,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
