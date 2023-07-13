import 'package:dune/domain/audio/base_models/base_thumbnail.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:isar/isar.dart';

part 'isar_thumbnail.g.dart';

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
