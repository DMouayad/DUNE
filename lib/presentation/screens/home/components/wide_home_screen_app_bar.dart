import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'app_bar_nav_buttons.dart';

class WideHomeScreenAppBar extends StatelessWidget {
  const WideHomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return ref.read(appPreferencesController).tabsMode.isEnabled
                  ? child!
                  : const SizedBox.shrink();
            },
            child: const AppBarNavButtons(),
          ),
          if (context.isDesktopPlatform && !kIsWeb)
            const Expanded(flex: 1, child: DesktopAppBarButtons()),
        ],
      ),
    );
  }
}
