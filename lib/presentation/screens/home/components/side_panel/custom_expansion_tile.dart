import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.children,
  });

  final String title;
  final List<Widget> children;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return fluent.Expander(
      contentBackgroundColor: Colors.transparent,
      contentShape: (_) =>
          const RoundedRectangleBorder(borderRadius: kBorderRadius),
      headerBackgroundColor: (_) => fluent.ButtonState.resolveWith((states) {
        return Colors.transparent;
      }),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      headerShape: (_) =>
          const RoundedRectangleBorder(borderRadius: kBorderRadius),
      header: Text(
        title,
        style: context.textTheme.titleSmall,
      ),
      leading: Icon(iconData, size: 20),
      content: Column(children: children),
    );
  }
}
