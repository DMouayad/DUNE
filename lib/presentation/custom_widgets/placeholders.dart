import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ArtistCoverPlaceholder extends StatelessWidget {
  const ArtistCoverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.surfaceVariant.withOpacity(.66),
      child: Icon(
        Icons.person_outline_outlined,
        color: context.colorScheme.secondary,
        size: context.trackThumbnailDimension,
      ),
    );
  }
}

class AlbumCoverPlaceholder extends StatelessWidget {
  const AlbumCoverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Icon(
        Icons.album_rounded,
        color: context.colorScheme.secondary,
      ),
    );
  }
}

class PlaylistCoverPlaceholder extends StatelessWidget {
  const PlaylistCoverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Icon(
        Icons.queue_music_outlined,
        color: context.colorScheme.secondary,
      ),
    );
  }
}

class TrackCoverPlaceholder extends StatelessWidget {
  const TrackCoverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.trackThumbnailDimension - 14;
    return Container(
      width: context.trackThumbnailDimension,
      height: context.trackThumbnailDimension,
      alignment: Alignment.center,
      child: Icon(
        Icons.music_note_outlined,
        size: size,
        color: context.colorScheme.secondary,
      ),
    );
  }
}
