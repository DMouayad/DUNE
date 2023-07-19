import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'isar_material_color.g.dart';

@Embedded(ignore: {'swatch', 'toMaterialColor'})
class IsarMaterialColor {
  final int? primary;

  /// The lightest shade.
  final int? shade50;

  /// The second lightest shade.
  final int? shade100;

  /// The third lightest shade.
  final int? shade200;

  /// The fourth lightest shade.
  final int? shade300;

  /// The fifth lightest shade.
  final int? shade400;

  /// The default shade.
  final int? shade500;

  /// The fourth darkest shade.
  final int? shade600;

  /// The third darkest shade.
  final int? shade700;

  /// The second darkest shade.
  final int? shade800;

  /// The darkest shade.
  final int? shade900;

  IsarMaterialColor({
    this.primary,
    this.shade50,
    this.shade100,
    this.shade200,
    this.shade300,
    this.shade400,
    this.shade500,
    this.shade600,
    this.shade700,
    this.shade800,
    this.shade900,
  });

  Map<int, Color> get swatch {
    return {
      50: Color(shade50!),
      100: Color(shade100!),
      200: Color(shade200!),
      300: Color(shade300!),
      400: Color(shade400!),
      500: Color(shade500!),
      600: Color(shade600!),
      700: Color(shade700!),
      800: Color(shade800!),
      900: Color(shade900!),
    };
  }

  MaterialColor get toMaterialColor {
    return MaterialColor(primary!, swatch);
  }

  static IsarMaterialColor? fromMaterialColor(MaterialColor? primaryColor) {
    if (primaryColor == null) return null;
    return IsarMaterialColor(
      primary: primaryColor.value,
      shade50: primaryColor.shade50.value,
      shade100: primaryColor.shade100.value,
      shade200: primaryColor.shade200.value,
      shade300: primaryColor.shade300.value,
      shade400: primaryColor.shade400.value,
      shade500: primaryColor.shade500.value,
      shade600: primaryColor.shade600.value,
      shade700: primaryColor.shade700.value,
      shade800: primaryColor.shade800.value,
      shade900: primaryColor.shade900.value,
    );
  }
}
