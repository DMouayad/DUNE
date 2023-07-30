import 'package:dune/domain/audio/base_models/thumbnails_set.dart';

import 'base_model_factory.dart';
import 'thumbnail_factory.dart';

final class ThumbnailsSetFactory extends BaseModelFactory<ThumbnailsSet> {
  late final List<BaseThumbnail>? _items;
  late final int? _itemsCount;
  late final bool? _isNetwork;

  ThumbnailsSetFactory() {
    _itemsCount = _isNetwork = _items = null;
  }

  @override
  ThumbnailsSet create() {
    return ThumbnailsSet.fromThumbnailsListWithUnknownQuality(
      _items ??
          ThumbnailFactory()
              .setIsNetwork(_isNetwork)
              .createCount(_itemsCount ?? 3),
    );
  }

  ThumbnailsSetFactory setItemsCount(int count) {
    return _copyWith(itemsCount: count);
  }

  ThumbnailsSetFactory _copyWith({
    List<BaseThumbnail>? items,
    int? itemsCount,
    bool? isNetwork,
  }) {
    return ThumbnailsSetFactory._(
      items: items ?? _items,
      itemsCount: itemsCount ?? _itemsCount,
      isNetwork: isNetwork ?? _isNetwork,
    );
  }

  ThumbnailsSetFactory._({
    required List<BaseThumbnail>? items,
    required int? itemsCount,
    required bool? isNetwork,
  })  : _items = items,
        _itemsCount = itemsCount,
        _isNetwork = isNetwork;
}
