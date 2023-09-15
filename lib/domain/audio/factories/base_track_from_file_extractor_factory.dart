import 'dart:async';
import 'dart:io';

import 'package:dune/domain/audio/services/base_file_track_extractor.dart';

abstract class BaseTrackFromFileExtractorFactory {
  final BaseTrackFromFileExtractor _extractor;

  const BaseTrackFromFileExtractorFactory(this._extractor);

  FutureOr<BaseTrackFromFileExtractor?> createExtractor(File file) async =>
      await _extractor.asyncConstructor(file);
}
