import 'dart:async';
import 'dart:io';

import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/domain/audio/base_models/track_audio_info.dart';
import 'package:dune/domain/audio/services/base_file_track_extractor.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/logger_service.dart';
import 'package:flutter_taggy/flutter_taggy.dart';

final class TaggyTrackFromFileExtractor extends BaseTrackFromFileExtractor {
  TaggyTrackFromFileExtractor();

  /// Contains the [file]'s metadata.
  /// should be assigned in [newExtractor] function.
  late final TaggyFile _taggyFile;
  late final Tag? _tag;

  TaggyTrackFromFileExtractor._(this._taggyFile, this._tag, {super.file});

  @override
  FutureOr<BaseTrackFromFileExtractor?> newExtractor(File file) async {
    try {
      final taggy = await Taggy.readAll(file.path);

      return TaggyTrackFromFileExtractor._(
        taggy,
        taggy.primaryTag ?? taggy.firstTagIfAny,
        file: file,
      );
    } catch (e) {
      Log.e(e);
      return null;
    }
  }

  @override
  BaseAlbum? extractAlbum() {
    return _tag?.album == null
        ? null
        : BaseAlbum(
            id: null,
            title: _tag!.album!,
            artists: const [],
            browseId: null,
            category: null,
            duration: null,
            isExplicit: false,
            thumbnails: const ThumbnailsSet(),
            type: null,
            tracks: const [],
            releaseDate: _tag!.year != null ? DateTime(_tag!.year!) : null,
            musicSource: MusicSource.local,
          ).setIdIfNull();
  }

  @override
  AudioInfoSet? extractAudioInfoSet() {
    final trackAudio = TrackAudioInfo(
      musicSource: MusicSource.local,
      url: file!.absolute.path,
      format: _taggyFile.fileType?.name,
      overallBitrate: _taggyFile.audio.overallBitrate,
      bitDepth: _taggyFile.audio.bitDepth,
      bitsPerSecond: _taggyFile.audio.audioBitrate?.toDouble(),
      samplingRate: _taggyFile.audio.sampleRate,
      channelMask: _taggyFile.audio.channelMask,
      channels: _taggyFile.audio.channels,
      totalBytes: _taggyFile.size,
    );
    return AudioInfoSet(items: [trackAudio]);
  }

  @override
  List<({List<int> data, BaseThumbnail thumb})> extractThumbnails() {
    return _tag?.pictures
            .map((e) => (
                  data: e.picData,
                  thumb: BaseThumbnail(
                    url: '',
                    isNetwork: false,
                    quality: ThumbnailQuality.standard,
                    width: e.width?.toDouble(),
                    height: e.height?.toDouble(),
                  ),
                ))
            .toList() ??
        [];
  }

  @override
  BaseTrack? extractTrack() {
    return BaseTrack(
      id: '',
      album: null,
      artists: const [],
      thumbnails: const ThumbnailsSet(),
      title: _tag?.trackTitle ?? '',
      year: _tag?.year?.toString(),
      views: null,
      category: _tag?.genre,
      duration: _taggyFile.audio.durationSec != null
          ? Duration(milliseconds: _taggyFile.audio.durationSec!)
          : null,
      isExplicit: false,
      audioInfoSet: const AudioInfoSet(),
      source: MusicSource.local,
    );
  }

  @override
  String? get getAlbumArtistString => _tag?.albumArtist;

  @override
  String? get getTrackArtistString => _tag?.trackArtist;
}
