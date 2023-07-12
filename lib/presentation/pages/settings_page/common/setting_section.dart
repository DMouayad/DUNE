import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({Key? key, required this.title, required this.contents})
      : super(key: key);
  final String title;
  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 2),
          child: Text(title,
              style: context.textTheme.titleMedium?.copyWith(
                // fontWeight: FontWeight.w500,
                color: context.colorScheme.secondary,
              )),
        ),
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: contents),
          ),
        ),
      ],
    );
  }
}
