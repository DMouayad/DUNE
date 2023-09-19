import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Text(
        title,
        style: context.textTheme.titleLarge,
      ),
    );
  }
}
