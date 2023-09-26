import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_expansion_tile.dart';

class PlaylistsDropdownButton extends ConsumerWidget {
  const PlaylistsDropdownButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return CustomExpansionTile(
      title: 'Playlists',
      iconData: CupertinoIcons.music_note_list,
      children: [
        const _PlaylistsOptions(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              // todo: add [trailing] with number of tracks
              title: Text('playlist $index'),
              onTap: () {},
              shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
              selectedColor:
                  context.colorScheme.onPrimaryContainer.withOpacity(.9),
              selected: true,
              dense: true,
            );
          },
        ),
      ],
    );
  }
}

class _PlaylistsOptions extends StatelessWidget {
  const _PlaylistsOptions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: IconButton(
            tooltip: 'Add new',
            icon: const Icon(Icons.add, size: 20),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: IconButton(
            tooltip: 'View all',
            icon: const Icon(Icons.read_more, size: 20),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
