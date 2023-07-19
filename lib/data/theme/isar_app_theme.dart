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
      isarPrimaryColor:
          IsarMaterialColor.fromMaterialColor(kDefaultPrimaryColor),
      windowEffect: WindowEffect.solid,
    );
  }

  final Id? id;

  @override
  @enumerated
  ThemeMode get themeMode => super.themeMode;

  @override
  @enumerated
  WindowEffect get windowEffect => super.windowEffect;
  final IsarMaterialColor? isarPrimaryColor;

  IsarAppTheme({
    this.id,
    this.isarPrimaryColor,
    super.themeMode = ThemeMode.system,
    super.windowEffect,
  }) : super(
          primaryColor:
              isarPrimaryColor?.toMaterialColor ?? kDefaultPrimaryColor,
        );
}
