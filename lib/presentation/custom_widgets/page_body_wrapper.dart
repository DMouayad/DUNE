import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageBodyWrapper extends ConsumerWidget {
  final Widget child;
  final List<Widget> actions;
  final bool tabsModeEnabled;

  const PageBodyWrapper({
    super.key,
    required this.child,
    required this.tabsModeEnabled,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);
    return Container(
      padding: tabsModeEnabled
          ? const EdgeInsets.all(16)
          : const EdgeInsets.fromLTRB(4, 24, 4, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: appTheme.acrylicWindowEffectEnabled
            ? Colors.transparent
            : context.colorScheme.background,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (actions.isNotEmpty)
            Positioned(
              top: 4,
              right: 6,
              child: ButtonBar(children: actions),
            ),
          Positioned.fill(top: 0, child: child),
        ],
      ),
    );
  }
}
