import 'package:dune/data/audio/youtube/models/youtube_playlist.dart';
import 'package:dune/data/audio/youtube/models/youtube_track.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

mixin YoutubeExplodeProxy {
  static YoutubePlaylist toduneYoutubePlaylist(
    Playlist playlist,
    List<Video> videos,
  ) {
    final pl = YoutubePlaylist(
      id: playlist.id.value,
      author: PlaylistAuthor(name: playlist.author),
      description: playlist.description,
      duration: null,
      durationSeconds: null,
      thumbnails: _getThumbnailsSet(playlist.thumbnails),
      title: playlist.title,
      tracks: videos.map((e) => videoToYoutubeTrack(e)).toList(),
    );
    return pl;
  }

  static YoutubeTrack videoToYoutubeTrack(Video video) {
    return YoutubeTrack(
      id: video.id.value,
      thumbnails: _getThumbnailsSet(video.thumbnails),
      title: video.title,
      year: video.publishDate?.year.toString(),
      views: video.engagement.viewCount,
      category: video.keywords.join(', '),
      duration: video.duration ?? Duration.zero,
    );
  }

  static ThumbnailsSet _getThumbnailsSet(ThumbnailSet set) {
    return ThumbnailsSet(thumbnails: [
      BaseThumbnail(
        isNetwork: true,
        url: set.standardResUrl,
        quality: ThumbnailQuality.standard,
      ),
      BaseThumbnail(
        isNetwork: true,
        url: set.mediumResUrl,
        quality: ThumbnailQuality.medium,
      ),
      BaseThumbnail(
        isNetwork: true,
        url: set.highResUrl,
        quality: ThumbnailQuality.high,
      ),
      BaseThumbnail(
        isNetwork: true,
        url: set.maxResUrl,
        quality: ThumbnailQuality.max,
      ),
    ]);
  }
}
