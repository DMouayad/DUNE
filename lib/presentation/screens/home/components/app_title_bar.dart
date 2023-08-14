import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/presentation/custom_widgets/full_screen_search_bar.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'tabs_bar.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({
    required this.tabsModeEnabled,
    this.onTabChanged,
    this.onAddNewTab,
    super.key,
  });

  final void Function()? onAddNewTab;
  final void Function(int index)? onTabChanged;
  final bool tabsModeEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        children: [
          DragToMoveArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'DUNE',
                      textAlign: TextAlign.start,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.secondary,
                        fontFamily: 'bruno_ace',
                      ),
                    ),
                  ),
                ),
                const Expanded(child: FullScreenSearchBar()),
                if (context.isDesktopPlatform && !kIsWeb)
                  const Expanded(flex: 0, child: DesktopAppBarButtons()),
              ],
            ),
          ),
          const SizedBox(height: 6),
          if (tabsModeEnabled)
            TabsBar(onTabChanged: onTabChanged, onAddNewTab: onAddNewTab),
        ],
      ),
    );
  }
}
