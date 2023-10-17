import 'package:dune/support/enums/quick_nav_destination.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'custom_expansion_tile.dart';

final _key = UniqueKey();

class LibraryDropdownButton extends StatelessWidget {
  LibraryDropdownButton({required this.onDestSelected}) : super(key: _key);
  final void Function(QuickNavDestination dest) onDestSelected;
  static const libraryPages = [
    (
      dest: QuickNavDestination.libraryTracksPage,
      title: 'Tracks',
      icon: fluent.FluentIcons.music_in_collection
    ),
    (
      dest: QuickNavDestination.libraryAlbumsPage,
      title: 'Albums',
      icon: CupertinoIcons.music_albums
    ),
    (
      dest: QuickNavDestination.libraryArtistsPage,
      title: 'Artists',
      icon: CupertinoIcons.rectangle_stack_person_crop
    ),
    (
      dest: QuickNavDestination.libraryFoldersPage,
      title: 'Folders',
      icon: fluent.FluentIcons.folder
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      title: 'Library',
      iconData: CupertinoIcons.music_house,
      children: libraryPages
          .map((e) => ListTile(
                onTap: () => onDestSelected(e.dest),
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
