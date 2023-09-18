import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/presentation/custom_widgets/top_search_bar.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({
    super.key,
  });

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
                    padding: const EdgeInsets.only(right: 20.0, left: 10),
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
                Expanded(
                  flex: context.screenWidth > 800 ? 0 : 1,
                  child: const TopSearchBar(),
                ),
                if (context.isDesktopPlatform && !kIsWeb)
                  const Expanded(flex: 0, child: DesktopAppBarButtons()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
