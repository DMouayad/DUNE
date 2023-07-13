import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

import 'base_thumbnail.dart';
export 'base_thumbnail.dart';

class ThumbnailsSet extends Equatable {
  final List<BaseThumbnail> thumbnails;

  const ThumbnailsSet({this.thumbnails = const []});

  Map<String, dynamic> toMap() {
    return {'thumbnails': thumbnails.map((e) => e.toMap()).toList()};
  }

  factory ThumbnailsSet.fromMap(Map<String, dynamic> map) {
    final thumbsList = map.whereKey('thumbnails');
    return ThumbnailsSet(
        thumbnails: (thumbsList is Iterable<Map<String, dynamic>>)
            ? thumbsList.map((e) => BaseThumbnail.fromMap(e)).toList()
            : []);
  }

  BaseThumbnail? whereQuality(ThumbnailQuality quality) {
    return thumbnails.firstWhereOrNull((e) => e.quality == quality);
  }

  ThumbnailsSet get onlyLocalThumbnailsSet {
    return ThumbnailsSet(
        thumbnails: thumbnails.where((value) => !value.isNetwork).toList());
  }

  BaseThumbnail byOrder(ThumbnailQualitiesOrderOption orderOption) {
    for (ThumbnailQuality quality in orderOption.qualities) {
      final thumb = thumbnails.firstWhereOrNull((e) => e.quality == quality);
      if (thumb != null) return thumb;
    }
    return any;
  }

  BaseThumbnail? byOrderOrNull(
    ThumbnailQualitiesOrderOption orderOption, {
    bool networkImagesOnly = false,
  }) {
    for (ThumbnailQuality quality in orderOption.qualities) {
      final thumb = thumbnails.firstWhereOrNull((e) =>
          e.quality == quality && (networkImagesOnly ? e.isNetwork : true));
      if (thumb != null) return thumb;
    }
    return null;
  }

  BaseThumbnail get any {
    return whereQuality(ThumbnailQuality.standard) ??
        whereQuality(ThumbnailQuality.medium) ??
        whereQuality(ThumbnailQuality.high) ??
        whereQuality(ThumbnailQuality.max) ??
        whereQuality(ThumbnailQuality.low) ??
        const BaseThumbnail(
          url: kCoverImagePlaceHolderUrl,
          quality: ThumbnailQuality.standard,
          isNetwork: true,
        );
  }

  List<String> get thumbnailUrls => thumbnails.map((e) => e.url).toList();

  factory ThumbnailsSet.fromThumbnailsListWithUnknownQuality(
    List<BaseThumbnail> list,
  ) {
    List<BaseThumbnail> _thumbnails = [];
    BaseThumbnail? lowQualityThumb;
    BaseThumbnail? mediumQualityThumb;
    BaseThumbnail? highQualityThumb;
    BaseThumbnail maxQualityThumb = list.first;
    for (BaseThumbnail item in list) {
      if (item.width != null &&
          maxQualityThumb.width != null &&
          item.width! > maxQualityThumb.width!) {
        highQualityThumb =
            maxQualityThumb.copyWith(quality: ThumbnailQuality.high);
        maxQualityThumb = item.copyWith(quality: ThumbnailQuality.max);
      } else if (item.width != null &&
          maxQualityThumb.width != null &&
          item.width! < maxQualityThumb.width!) {
        if (lowQualityThumb?.width != null &&
            item.width! < lowQualityThumb!.width!) {
          mediumQualityThumb =
              lowQualityThumb.copyWith(quality: ThumbnailQuality.medium);
          lowQualityThumb = item.copyWith(quality: ThumbnailQuality.low);
        } else {
          mediumQualityThumb ??=
              item.copyWith(quality: ThumbnailQuality.medium);
        }
      } else {
        _thumbnails.add(item);
      }
    }
    return ThumbnailsSet(thumbnails: [
      ..._thumbnails,
      if (mediumQualityThumb != null) mediumQualityThumb,
      if (highQualityThumb != null) highQualityThumb,
      if (lowQualityThumb != null) lowQualityThumb,
      maxQualityThumb
    ]);
  }

  @override
  String toString() {
    return '$runtimeType: {thumbnails: [${thumbnails.map((e) => e.toString()).toList()}]}';
  }

  @override
  List<Object?> get props => [thumbnails];
}
