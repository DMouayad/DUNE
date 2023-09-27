import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/screens/home/components/side_panel/wide_app_bar_buttons.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WideHomeScreenAppBar extends StatelessWidget {
  const WideHomeScreenAppBar({super.key, required this.tabsEnabled});

  final bool tabsEnabled;

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: SizedBox(
        height: kWideScreenAppBarHeight,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              top: 0,
              left: 14,
              child: Row(
                children: [
                  Text(
                    'DUNE',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.secondary,
                      fontFamily: 'baloo2',
                    ),
                  ),
                  if (tabsEnabled)
                    OptionalParentWidget(
                      condition: context.isDesktopPlatform,
                      parentWidgetBuilder: (child) => VisibilityOnHover(
                        size: Size(context.screenWidth, 40),
                        child: child,
                      ),
                      childWidget: const WideAppBarButtons(),
                    ),
                ],
              ),
            ),
            if (context.isDesktopPlatform && !kIsWeb)
              const Positioned(right: 0, top: 0, child: DesktopAppBarButtons()),
          ],
        ),
      ),
    );
  }
}

class VisibilityOnHover extends StatefulWidget {
  const VisibilityOnHover({
    super.key,
    required this.child,
    required this.size,
  });

  final Widget child;
  final Size size;

  @override
  State<VisibilityOnHover> createState() => _VisibilityOnHoverState();
}

class _VisibilityOnHoverState extends State<VisibilityOnHover> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(
        width: widget.size.width,
        height: widget.size.height,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => hovered = true),
        onExit: (_) {
          // set as not-visible but only update the widget after the duration
          // in case the user re-hovered again before the waiting ends.
          hovered = false;
          Future.delayed(const Duration(seconds: 1), () => setState(() {}));
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 280),
          opacity: hovered ? 1 : 0,
          child: Row(children: [widget.child]),
        ),
      ),
    );
  }
}
