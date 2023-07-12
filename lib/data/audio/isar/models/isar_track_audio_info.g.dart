// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_track_audio_info.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarTrackAudioInfoSchema = Schema(
  name: r'IsarTrackAudioInfo',
  id: 526569056173480730,
  properties: {
    r'bitrateInKb': PropertySchema(
      id: 0,
      name: r'bitrateInKb',
      type: IsarType.double,
    ),
    r'format': PropertySchema(
      id: 1,
      name: r'format',
      type: IsarType.string,
    ),
    r'musicSource': PropertySchema(
      id: 2,
      name: r'musicSource',
      type: IsarType.byte,
      enumMap: _IsarTrackAudioInfomusicSourceEnumValueMap,
    ),
    r'quality': PropertySchema(
      id: 3,
      name: r'quality',
      type: IsarType.byte,
      enumMap: _IsarTrackAudioInfoqualityEnumValueMap,
    ),
    r'totalBytes': PropertySchema(
      id: 4,
      name: r'totalBytes',
      type: IsarType.long,
    ),
    r'url': PropertySchema(
      id: 5,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _isarTrackAudioInfoEstimateSize,
  serialize: _isarTrackAudioInfoSerialize,
  deserialize: _isarTrackAudioInfoDeserialize,
  deserializeProp: _isarTrackAudioInfoDeserializeProp,
);

int _isarTrackAudioInfoEstimateSize(
  IsarTrackAudioInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.format;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarTrackAudioInfoSerialize(
  IsarTrackAudioInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bitrateInKb);
  writer.writeString(offsets[1], object.format);
  writer.writeByte(offsets[2], object.musicSource.index);
  writer.writeByte(offsets[3], object.quality.index);
  writer.writeLong(offsets[4], object.totalBytes);
  writer.writeString(offsets[5], object.url);
}

IsarTrackAudioInfo _isarTrackAudioInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarTrackAudioInfo(
    bitrateInKb: reader.readDoubleOrNull(offsets[0]),
    format: reader.readStringOrNull(offsets[1]),
    quality: _IsarTrackAudioInfoqualityValueEnumMap[
            reader.readByteOrNull(offsets[3])] ??
        AudioStreamingQuality.undefined,
    totalBytes: reader.readLongOrNull(offsets[4]),
    url: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _isarTrackAudioInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (_IsarTrackAudioInfomusicSourceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MusicSource.youtube) as P;
    case 3:
      return (_IsarTrackAudioInfoqualityValueEnumMap[
              reader.readByteOrNull(offset)] ??
          AudioStreamingQuality.undefined) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarTrackAudioInfomusicSourceEnumValueMap = {
  'youtube': 0,
  'spotify': 1,
  'local': 2,
  'unknown': 3,
};
const _IsarTrackAudioInfomusicSourceValueEnumMap = {
  0: MusicSource.youtube,
  1: MusicSource.spotify,
  2: MusicSource.local,
  3: MusicSource.unknown,
};
const _IsarTrackAudioInfoqualityEnumValueMap = {
  'undefined': 0,
  'lowest': 1,
  'low': 2,
  'balanced': 3,
  'high': 4,
  'best': 5,
};
const _IsarTrackAudioInfoqualityValueEnumMap = {
  0: AudioStreamingQuality.undefined,
  1: AudioStreamingQuality.lowest,
  2: AudioStreamingQuality.low,
  3: AudioStreamingQuality.balanced,
  4: AudioStreamingQuality.high,
  5: AudioStreamingQuality.best,
};

extension IsarTrackAudioInfoQueryFilter
    on QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QFilterCondition> {
  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      bitrateInKbIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bitrateInKb',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      bitrateInKbIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bitrateInKb',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      bitrateInKbEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bitrateInKb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      bitrateInKbGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bitrateInKb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      bitrateInKbLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bitrateInKb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      bitrateInKbBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bitrateInKb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'format',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'format',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'format',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'format',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'format',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      formatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'format',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      musicSourceEqualTo(MusicSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'musicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      musicSourceGreaterThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'musicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      musicSourceLessThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'musicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      musicSourceBetween(
    MusicSource lower,
    MusicSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'musicSource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      qualityEqualTo(AudioStreamingQuality value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      qualityGreaterThan(
    AudioStreamingQuality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      qualityLessThan(
    AudioStreamingQuality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      qualityBetween(
    AudioStreamingQuality lower,
    AudioStreamingQuality upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      totalBytesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalBytes',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      totalBytesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalBytes',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      totalBytesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      totalBytesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      totalBytesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      totalBytesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalBytes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension IsarTrackAudioInfoQueryObject
    on QueryBuilder<IsarTrackAudioInfo, IsarTrackAudioInfo, QFilterCondition> {}
