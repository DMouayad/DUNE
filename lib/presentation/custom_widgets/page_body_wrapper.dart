import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';

class PageBodyWrapper extends ConsumerWidget {
  final Widget child;

  const PageBodyWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);

    return context.isMobile
        ? child
        : ClipRRect(
            borderRadius: kBorderRadius,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: appTheme.acrylicWindowEffectEnabled
                    ? Colors.transparent
                    : context.colorScheme.background,
                borderRadius: kBorderRadius,
              ),
              child: child,
            ),
          );
  }
}
