import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageBodyWrapper extends ConsumerWidget {
  final Widget child;

  const PageBodyWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);
    final childWithPadding = OptionalParentWidget(
      condition: false,
      parentWidgetBuilder: (child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.bottomPlayerBarHeight,
            left: 10,
          ),
          child: child,
        );
      },
      childWidget: child,
    );
    return context.isMobile
        ? childWithPadding
        : Container(
            padding: ref.watch(appPreferencesController).tabsModeEnabled
                ? const EdgeInsets.all(16)
                : const EdgeInsets.only(right: 4, left: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: appTheme.acrylicWindowEffectEnabled
                  ? Colors.transparent
                  : context.colorScheme.background,
            ),
            child: child,
          );
  }
}
