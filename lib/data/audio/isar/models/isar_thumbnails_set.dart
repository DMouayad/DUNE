import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

import 'isar_thumbnail.dart';
export 'isar_thumbnail.dart';

part 'isar_thumbnails_set.g.dart';

@Embedded(ignore: {
  'thumbnailUrls',
  'imageUrl',
  'props',
  'derived',
  'any',
  'onlyLocalThumbnailsSet',
  'hashCode',
  'stringify',
  'thumbnails',
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
