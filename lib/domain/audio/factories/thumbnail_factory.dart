import 'package:dune/domain/audio/base_models/base_thumbnail.dart';
import 'package:faker/faker.dart';

import 'base_model_factory.dart';

final class ThumbnailFactory extends BaseModelFactory<BaseThumbnail> {
  late final String? _url;
  late final double? _width;
  late final double? _height;
  late final ThumbnailQuality? _quality;
  late final bool? _isNetwork;

  ThumbnailFactory() {
    _url = _width = _height = _quality = _isNetwork = null;
  }

  @override
  BaseThumbnail create() {
    final double width =
        _width ?? faker.randomGenerator.integer(1080).toDouble();
    final double height =
        _height ?? faker.randomGenerator.integer(1080).toDouble();
    return BaseThumbnail(
      url: _url ??
          faker.image.image(width: width.toInt(), height: height.toInt()),
      quality: _quality ?? ThumbnailQuality.low,
      isNetwork: _isNetwork ?? faker.randomGenerator.boolean(),
      height: _height ?? height,
      width: _width ?? width,
    );
  }

  ThumbnailFactory setIsNetwork(bool? isNetwork) {
    return _copyWith(isNetwork: isNetwork);
  }

  ThumbnailFactory._({
    required String? url,
    required double? width,
    required double? height,
    required ThumbnailQuality? quality,
    required bool? isNetwork,
  })  : _url = url,
        _width = width,
        _height = height,
        _quality = quality,
        _isNetwork = isNetwork;

  ThumbnailFactory _copyWith({
    String? url,
    double? width,
    double? height,
    ThumbnailQuality? quality,
    bool? isNetwork,
  }) {
    return ThumbnailFactory._(
      url: url ?? _url,
      width: width ?? _width,
      height: height ?? _height,
      quality: quality ?? _quality,
      isNetwork: isNetwork ?? _isNetwork,
    );
  }
}
