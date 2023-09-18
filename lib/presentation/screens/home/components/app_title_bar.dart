import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/presentation/custom_widgets/top_search_bar.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DragToMoveArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 0,
                child: Container(
                  width: context.maxNavRailWidth + 16,
                  padding: const EdgeInsets.only(left: 18, top: 6),
                  child: Text(
                    'D',
                    textAlign: TextAlign.start,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.colorScheme.secondary,
                      fontFamily: 'bruno_ace',
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: context.screenWidth > 860 ? 0 : 1,
                child: const TopSearchBar(),
              ),
              if (context.isDesktopPlatform && !kIsWeb)
                const Expanded(flex: 1, child: DesktopAppBarButtons()),
            ],
          ),
        ),
      ],
    );
  }
}
