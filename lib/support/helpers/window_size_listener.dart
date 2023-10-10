import 'dart:ui';

import 'package:dune/presentation/providers/state_controllers.dart';
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

  bool get _shouldSaveLastWindowSize =>
      _ref.watch(appPreferencesController).rememberLastWindowSize;

  void _saveWindowSize(Size size) {
    _ref.read(appPreferencesController.notifier).setLastWindowSize(size);
  }
}
