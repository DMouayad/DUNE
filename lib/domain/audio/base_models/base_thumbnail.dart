import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

class BaseThumbnail extends Equatable {
  const BaseThumbnail({
    required this.url,
    required this.quality,
    this.height,
    this.width,
  });

  final String url;
  final double? width;
  final double? height;
  final ThumbnailQuality quality;

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'quality': quality.name,
      if (width != null) 'width': width,
      if (height != null) 'height': height
    };
  }

  factory BaseThumbnail.fromMap(Map<String, dynamic> map) {
    return BaseThumbnail(
      url: map['url'],
      quality: ThumbnailQuality.values
              .asNameMap()
              .keys
              .contains(map.whereKey('quality'))
          ? ThumbnailQuality.values.byName(map.whereKey('quality'))
          : ThumbnailQuality.standard,
      height: map.whereKey('height') != null
          ? double.tryParse(map.whereKey('height')!.toString())
          : null,
      width: map.whereKey('width') != null
          ? double.tryParse(map.whereKey('width')!.toString())
          : null,
    );
  }

  static BaseThumbnail? tryFromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return BaseThumbnail.fromMap(map);
  }

  BaseThumbnail copyWith({
    String? url,
    double? width,
    double? height,
    ThumbnailQuality? quality,
  }) {
    return BaseThumbnail(
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
      quality: quality ?? this.quality,
    );
  }

  @override
  String toString() {
    return '$runtimeType: {width: $width, height: $height, url: $url, quality:${quality.name}}';
  }

  @override
  List<Object?> get props => [width, height, url, quality];
}

enum ThumbnailQuality { standard, low, medium, high, max }
