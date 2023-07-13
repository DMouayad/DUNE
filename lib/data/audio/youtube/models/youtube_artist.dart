import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/extensions/extensions.dart';

class YoutubeArtist extends BaseArtist {
  const YoutubeArtist({
    required super.id,
    required super.name,
    super.description = '',
    super.browseId,
    super.shuffleId,
    super.radioId,
    super.albums = const [],
    super.thumbnails = const ThumbnailsSet(),
    super.category,
    super.tracks = const [],
  });

  @override
  Set<Type> get derived => {BaseArtist};

  factory YoutubeArtist.fromMap(Map<String, dynamic> map) {
    return YoutubeArtist(
      id: map.whereKey('id'),
      name: map.whereKey('artist') ?? map.whereKey('name') ?? 'Unknown',
      browseId: map.whereKey("browseId"),
      category: map.whereKey("category"),
      radioId: map.whereKey("radioId"),
      shuffleId: map.whereKey("shuffleId"),
      thumbnails: map.whereKey('thumbnails') != null
          ? ThumbnailsSet.fromThumbnailsListWithUnknownQuality(
              (map.whereKey('thumbnails') as Iterable)
                  .map((e) => BaseThumbnail(
                        url: e['url'],
                        quality: ThumbnailQuality.standard,
                        width: _parseDoubleFromMap(e, "width"),
                        height: _parseDoubleFromMap(e, "height"),
                        isNetwork: true,
                      ))
                  .toList(),
            )
          : const ThumbnailsSet(),
    );
  }

  static double? _parseDoubleFromMap(e, String key) {
    return e[key] is String
        ? double.tryParse(e[key])
        : e[key] is int
            ? (e[key] as int).toDouble()
            : null;
  }
}
