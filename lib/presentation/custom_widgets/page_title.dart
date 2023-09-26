import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(this.title, {this.padding, super.key});

  final String title;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        title,
        style: context.textTheme.titleLarge,
      ),
    );
  }
}
