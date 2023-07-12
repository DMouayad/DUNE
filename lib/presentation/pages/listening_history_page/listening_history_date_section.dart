import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ListeningHistoryDateSectionHeader extends StatelessWidget {
  const ListeningHistoryDateSectionHeader({
    Key? key,
    this.alignment,
    required this.trailing,
    required this.date,
  }) : super(key: key);

  final String trailing;
  final DateTime date;
  final MainAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          const Divider(),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: alignment ?? MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getDayFromDifference(date),
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const VerticalDivider(),
                  Text(
                    trailing,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  String _getDayFromDifference(DateTime date) {
    return switch (date.difference(DateTime.now()).inDays) {
      0 => 'today'.toUpperCase(),
      -1 => 'yesterday'.toUpperCase(),
      _ => '${date.month}/${date.day}/${date.year}',
    };
  }
}
