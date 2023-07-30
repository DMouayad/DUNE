import 'package:flutter/material.dart';

class ListeningHistorySummaryTab extends StatelessWidget {
  const ListeningHistorySummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          left: 0,
          top: 4,
          child: _MonthSelectionBar(),
        ),
      ],
    );
  }
}

class _MonthSelectionBar extends StatelessWidget {
  const _MonthSelectionBar();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
