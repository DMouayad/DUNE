import 'package:dune/domain/theme/app_theme.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:isar/isar.dart';

import 'isar_material_color.dart';

part 'isar_app_theme.g.dart';

@Collection(inheritance: false, ignore: {'primaryColor'})
class IsarAppTheme extends AppTheme {
  factory IsarAppTheme.fromDefaultValues() {
    return IsarAppTheme(
      themeMode: ThemeMode.system,
      primaryColor: kDefaultPrimaryColor,
      windowEffect: WindowEffect.solid,
    );
  }

  final Id? id;

  @override
  MaterialColor get primaryColor {
    return _isarPrimaryColor != null
        ? MaterialColor(
            _isarPrimaryColor!.primary!,
            _isarPrimaryColor!.swatch,
          )
        : kDefaultPrimaryColor;
  }

  @override
  @enumerated
  ThemeMode get themeMode => super.themeMode;

  @override
  @enumerated
  WindowEffect get windowEffect => super.windowEffect;
  late final IsarMaterialColor? _isarPrimaryColor;

  IsarAppTheme({
    super.themeMode = ThemeMode.system,
    MaterialColor? primaryColor,
    super.windowEffect,
    this.id,
  })  : _isarPrimaryColor = IsarMaterialColor.fromMaterialColor(primaryColor),
        super(primaryColor: primaryColor ?? kDefaultPrimaryColor);
}
