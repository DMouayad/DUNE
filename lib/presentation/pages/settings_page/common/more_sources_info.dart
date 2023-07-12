import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class MoreSourcesFeatureInfo extends StatelessWidget {
  const MoreSourcesFeatureInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.info_outline,
        size: 20,
        color: context.colorScheme.error,
      ),
      title: Text(
        "Currently YouTube is the only available source but "
        "more will be made available in the near future",
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.error,
        ),
      ),
    );
  }
}
