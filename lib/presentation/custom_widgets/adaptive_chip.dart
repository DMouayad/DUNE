import 'dart:math';

import 'package:dune/support/context_builders/custom_builders.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class AdaptiveChip<T> extends StatelessWidget {
  const AdaptiveChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onPressed,
  });

  final String text;
  final bool selected;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      fallBackChild: _materialChip(context),
      windowsChild: _fluentUiChip(context),
    ).of(context)!;
  }

  Widget _materialChip(BuildContext context) {
    return FilterChip(
      checkmarkColor: context.colorScheme.primary,
      selectedColor: context.colorScheme.primaryContainer,
      padding: const EdgeInsets.all(8),
      surfaceTintColor: context.colorScheme.secondaryContainer,
      selected: selected,
      onSelected: onPressed != null ? (_) => onPressed!() : null,
      label: _getLabel(text, context, selected),
    );
  }

  Widget _fluentUiChip(BuildContext context) {
    return fluent.SizedBox(
      height: 38,
      width: min(150, context.screenWidth * .4),
      child: fluent.Button(
        onPressed: onPressed,
        style: fluent.ButtonStyle(
          backgroundColor: fluent.ButtonState.resolveWith((states) {
            Color color;
            if (selected) {
              color = context.colorScheme.primaryContainer
                  .withOpacity(context.isDarkMode ? .8 : 1);
            } else {
              color = context.colorScheme.secondaryContainer
                  .withOpacity(states.isHovering || states.isPressing ? 1 : .4);
            }
            return color;
          }),
        ),
        child: fluent.Center(
          child: _getLabel(text, context, selected),
        ),
      ),
    );
  }

  Widget _getLabel(String text, BuildContext context, bool selected) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyMedium?.copyWith(
        color: selected
            ? context.colorScheme.onPrimaryContainer
            : context.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
