import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'app_bar_nav_buttons.dart';

class WideHomeScreenAppBar extends StatelessWidget {
  const WideHomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: SizedBox(
        height: kWideScreenAppBarHeight,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(left: 0, top: 4, child: _LeadingIcons()),
            if (context.isDesktopPlatform && !kIsWeb)
              const Positioned(right: 0, top: 0, child: DesktopAppBarButtons()),
          ],
        ),
      ),
    );
  }
}

class _LeadingIcons extends ConsumerWidget {
  const _LeadingIcons();

  @override
  Widget build(BuildContext context, ref) {
    final tabsMode = ref.read(appPreferencesController).tabsMode;
    return Wrap(
      spacing: 10,
      children: [
        if (tabsMode.isVertical) ...[
          const CustomBackButton(),
          const CustomForwardButton(),
        ],
        if (tabsMode.isEnabled)
          fluent.IconButton(
            onPressed: () {},
            icon: Icon(
              fluent.FluentIcons.history,
              color: context.colorScheme.onBackground,
              size: 16,
            ),
          ),
      ],
    );
  }
}
