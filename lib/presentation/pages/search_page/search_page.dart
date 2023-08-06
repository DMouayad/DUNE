import 'package:dune/presentation/custom_widgets/page_title.dart';
import 'package:dune/presentation/pages/search_page/moods_genres_section.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return fluent.LayoutBuilder(builder: (context, constraints) {
      return const fluent.ScaffoldPage(
        header: PageTitle('Search'),
        padding: kPagePadding,
        content: MoodsAndCategoriesSection(),
      );
    });
  }
}
