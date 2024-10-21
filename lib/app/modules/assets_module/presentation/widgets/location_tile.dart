import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minicore_arch_example/app/modules/assets_module/interactor/models/location_model.dart';

class LocationModelWidget extends StatelessWidget {
  final LocationModel item;
  final bool isExpanded;
  final bool showChevron;
  final void Function()? onTap;

  const LocationModelWidget({
    required this.item,
    required this.isExpanded,
    required this.showChevron,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (showChevron)
            Icon(
              isExpanded ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_right,
            ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              CupertinoIcons.placemark,
              color: colorScheme.primary,
            ),
          ),
          Flexible(
            child: Text(
              item.name,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
