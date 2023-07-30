import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingComponentCard extends ConsumerWidget {
  const SettingComponentCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.children,
    this.trailing,
    this.contentPadding,
    this.trailingText,
  });

  final String title;
  final IconData iconData;
  final Widget? trailing;
  final String? trailingText;
  final List<Widget> children;

  /// if not provided, it's set to `EdgeInsets.zero`
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context, ref) {
    return fluent_ui.Padding(
      padding: const EdgeInsets.all(4.0),
      child: fluent_ui.Expander(
        headerShape: (expanded) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(expanded ? 2 : 10),
          );
        },
        contentBackgroundColor: ref.watch(appThemeControllerProvider).cardColor,
        trailing: trailing ??
            (trailingText != null ? _getTrailingTextWidget(context) : null),
        header: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(iconData, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.onPrimaryContainer.withOpacity(.9),
                ),
              ),
            ),
          ],
        ),
        content: Padding(
          padding: contentPadding ?? EdgeInsets.zero,
          child: Column(children: children),
        ),
      ),
    );
  }

  Widget _getTrailingTextWidget(BuildContext context) {
    return Text(
      '( $trailingText )',
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.onPrimaryContainer,
      ),
    );
  }
}
