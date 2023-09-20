import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'custom_expansion_tile.dart';

const _libraryPages = [
  (title: 'Tracks', icon: fluent.FluentIcons.music_in_collection),
  (title: 'Albums', icon: CupertinoIcons.music_albums),
  (title: 'Artists', icon: CupertinoIcons.rectangle_stack_person_crop),
  (title: 'Folders', icon: fluent.FluentIcons.folder),
];

class LibraryDropdownButton extends StatelessWidget {
  const LibraryDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      title: 'Library',
      iconData: CupertinoIcons.music_house,
      children: _libraryPages
          .map((e) => ListTile(
                onTap: () {},
                shape:
                    const RoundedRectangleBorder(borderRadius: kBorderRadius),
                selectedColor:
                    context.colorScheme.onPrimaryContainer.withOpacity(.9),
                selected: true,
                dense: true,
                leading: Icon(e.icon, size: 18),
                title: Text(e.title),
              ))
          .toList(),
    );
  }
}
