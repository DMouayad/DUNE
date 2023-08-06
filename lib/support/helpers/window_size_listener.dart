import 'dart:ui';

import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/screens/home/components/side_panel/side_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowSizeListener extends WindowListener {
  AppWindowSizeListener(this._ref);

  final WidgetRef _ref;

  @override
  void onWindowResized() async {
    final newSize = await windowManager.getSize();
    if (_shouldSaveLastWindowSize) {
      _saveWindowSize(newSize);
    }
    super.onWindowResized();
  }

  @override
  Future<void> onWindowResize() async {
    var size = (await windowManager.getSize());
    if (size.width < 600.0) {
      if (_ref.watch(navigationRailSizeProvider) != size.width &&
          _ref.watch(navigationRailSizeProvider) != kSidePanelMinWidth) {
        _ref.read(navigationRailSizeProvider.notifier).state =
            kSidePanelMinWidth;
      }
    }
    super.onWindowResize();
  }

  bool get _shouldSaveLastWindowSize =>
      _ref.watch(appPreferencesController).rememberLastWindowSize;

  void _saveWindowSize(Size size) {
    _ref.read(appPreferencesController.notifier).setLastWindowSize(size);
  }
}
