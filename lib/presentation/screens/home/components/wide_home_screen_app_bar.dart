import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
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
              top: 2,
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
                  if (tabsEnabled) const WideAppBarButtons(),
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
