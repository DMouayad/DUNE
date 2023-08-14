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

    return context.isMobile
        ? child
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: appTheme.acrylicWindowEffectEnabled
                  ? Colors.transparent
                  : context.colorScheme.background,
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: child,
          );
  }
}
