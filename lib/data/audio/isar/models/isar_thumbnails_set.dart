import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

part 'isar_thumbnails_set.g.dart';

@Embedded(ignore: {
  'thumbnailUrls',
  'imageUrl',
  'props',
  'derived',
  'any',
  'onlyLocalThumbnailsSet',
})
class IsarThumbnailsSet extends ThumbnailsSet {
  @override
  Set<Type> get derived => {ThumbnailsSet};

  @override
  List<IsarThumbnail> get thumbnails => thumbnailsList;

  final List<IsarThumbnail> thumbnailsList;

  const IsarThumbnailsSet({this.thumbnailsList = const []})
      : super(thumbnails: thumbnailsList);

  static IsarThumbnailsSet fromMap(Map<String, dynamic>? map) {
    if (map == null) return const IsarThumbnailsSet();
    final thumbsList = map.whereKey('thumbnails');
    return IsarThumbnailsSet(
      thumbnailsList: thumbsList is Iterable
          ? thumbsList.map((e) => IsarThumbnail.tryFromMap(e)!).toList()
          : [],
    );
  }
}

@Embedded(ignore: {'props', 'derived', 'hashCode', 'stringify'})
class IsarThumbnail extends BaseThumbnail {
  IsarThumbnail({
    super.height = 0,
    super.url = '',
    super.width = 0,
    super.quality = ThumbnailQuality.standard,
    super.isNetwork = true,
  });

  @override
  Set<Type> get derived => {BaseThumbnail};

  @override
  @enumerated
  ThumbnailQuality get quality => super.quality;

  static IsarThumbnail? tryFromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return IsarThumbnail(
      height: map.whereKey('height'),
      url: map.whereKey('url'),
      width: map.whereKey('width'),
      isNetwork: map.whereKey('isNetwork') ?? false,
      quality: ThumbnailQuality.values
              .asNameMap()
              .whereKey(map.whereKey('quality')) ??
          ThumbnailQuality.standard,
    );
  }
}
