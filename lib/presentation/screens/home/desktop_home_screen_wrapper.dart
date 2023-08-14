import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/presentation/custom_widgets/desktop_shortcuts_handler.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/helpers/app_window_helper.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:dune/support/helpers/window_size_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class DesktopHomeScreenWrapper extends ConsumerStatefulWidget {
  const DesktopHomeScreenWrapper(this.child, {super.key});

  final Widget child;

  @override
  ConsumerState<DesktopHomeScreenWrapper> createState() =>
      _DesktopHomeScreenWrapperState();
}

class _DesktopHomeScreenWrapperState
    extends ConsumerState<DesktopHomeScreenWrapper> {
  late final WindowListener appWindowSizeListener;

  @override
  void initState() {
    appWindowSizeListener = AppWindowSizeListener(ref);
    if (isDesktopNotWebPlatform) {
      windowManager.addListener(appWindowSizeListener);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppTheme>(
        appThemeControllerProvider, (p, n) => _onThemeChange(p, n, context));

    return DragToResizeArea(
      child: DesktopShortcutsHandler(child: widget.child),
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
