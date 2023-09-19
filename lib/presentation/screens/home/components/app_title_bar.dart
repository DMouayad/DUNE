import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 6, left: 18, right: 10),
              child: Text(
                'D',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.colorScheme.secondary,
                  fontFamily: 'bruno_ace',
                ),
              ),
            ),
          ),
          if (context.isDesktopPlatform && !kIsWeb)
            const Expanded(flex: 1, child: DesktopAppBarButtons()),
        ],
      ),
    );
  }
}
