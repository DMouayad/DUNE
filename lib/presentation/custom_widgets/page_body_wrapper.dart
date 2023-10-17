import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
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
              child: OptionalParentWidget(
                parentWidgetBuilder: (child) => _StatefulWrapper(child),
                condition: AppNavigation.instance.tabsEnabled,
                childWidget: child,
              ),
            ),
          );
  }
}

class _StatefulWrapper extends StatefulWidget {
  const _StatefulWrapper(this.child);

  final Widget child;

  @override
  State<_StatefulWrapper> createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<_StatefulWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
