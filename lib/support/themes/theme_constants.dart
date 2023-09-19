import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

const MaterialColor kDefaultPrimaryColor = Colors.blueGrey;
final fluent.AccentColor kFluentDefaultPrimaryColor =
    Colors.blueGrey.toAccentColor();

const supportedDesktopWindowEffects = [
  WindowEffect.solid,
  WindowEffect.acrylic,
];

bool get kIsWindowEffectsSupported => isDesktopNotWebPlatform;
const kBorderRadius = BorderRadius.all(Radius.circular(14));
