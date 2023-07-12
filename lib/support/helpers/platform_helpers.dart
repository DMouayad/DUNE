import 'dart:io';

import 'package:flutter/foundation.dart';

bool get isDesktopPlatform {
  return (Platform.isWindows || Platform.isMacOS || Platform.isLinux);
}

bool get isDesktopNotWebPlatform => isDesktopPlatform && !kIsWeb;

bool get platformSupportAccentColor =>
    kIsWeb ||
    [TargetPlatform.windows, TargetPlatform.android]
        .contains(defaultTargetPlatform);
