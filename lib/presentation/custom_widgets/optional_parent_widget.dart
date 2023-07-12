import 'package:flutter/material.dart';

/// Wraps the [childWidget] with a parent widget when the specified [condition]
/// is `true` otherwise, [childWidget] is returned.
class OptionalParentWidget extends StatelessWidget {
  final bool condition;
  final Widget Function(Widget child) parentWidgetBuilder;
  final Widget childWidget;

  const OptionalParentWidget({
    super.key,
    required this.condition,
    required this.parentWidgetBuilder,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? parentWidgetBuilder(childWidget) : childWidget;
  }
}
