import 'package:dune/presentation/pages/search_page/moods_genres_section.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return fluent.LayoutBuilder(builder: (context, constraints) {
      return fluent.ScaffoldPage(
        padding: EdgeInsets.zero,
        header: fluent.Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              Text(
                'Search',
                style: context.pageHeaderTextStyle,
              ),
            ],
          ),
        ),
        content: const MoodsAndCategoriesSection(),
      );
    });
  }
}
