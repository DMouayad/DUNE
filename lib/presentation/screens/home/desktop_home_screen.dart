import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/presentation/custom_widgets/desktop_shortcuts_handler.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/helpers/app_window_helper.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:dune/support/helpers/window_size_listener.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'home_screen.dart';
import 'wide_home_screen.dart';

class DesktopHomeScreen extends ConsumerStatefulWidget {
  const DesktopHomeScreen(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends ConsumerState<DesktopHomeScreen> {
  @override
  void initState() {
    if (isDesktopNotWebPlatform) {
      windowManager.addListener(AppWindowSizeListener(ref));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppTheme>(
        appThemeControllerProvider, (p, n) => _onThemeChange(p, n, context));
    return DragToResizeArea(
      child: DesktopShortcutsHandler(
        child: context.isMobile
            ? HomeScreen(widget.navigationShell)
            : WideHomeScreen(widget.navigationShell),
      ),
    );
  }

  void _onThemeChange(AppTheme? prev, AppTheme next, BuildContext context) {
    // if themeMode or the windowEffect was changed, set the app window
    // effect with the new effect and background color.

    if (prev != next) {
      AppWindowHelper.setWindowEffect(next);
    }
  }
}
