import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/custom_widgets/desktop_shortcuts_handler.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/helpers/app_window_helper.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:dune/support/helpers/window_size_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'wide_home_screen.dart';

class DesktopHomeScreen extends ConsumerStatefulWidget {
  const DesktopHomeScreen(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends ConsumerState<DesktopHomeScreen> {
  late final WindowListener appWindowSizeListener;

  @override
  void initState() {
    appWindowSizeListener = AppWindowSizeListener(ref);
    if (isDesktopNotWebPlatform) {
      windowManager.addListener(appWindowSizeListener);
    }
    GoRouter.of(context).routerDelegate.addListener(() {
      final shouldShowBackButton = AppRouter.canPop();
      if (shouldShowBackButton != ref.watch(showBackButtonProvider)) {
        ref
            .read(showBackButtonProvider.notifier)
            .update((state) => shouldShowBackButton);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    if (isDesktopNotWebPlatform) {
      windowManager.removeListener(appWindowSizeListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppTheme>(
        appThemeControllerProvider, (p, n) => _onThemeChange(p, n, context));

    return DragToResizeArea(
      child: DesktopShortcutsHandler(
        child: WideHomeScreen(widget.navigationShell),
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
