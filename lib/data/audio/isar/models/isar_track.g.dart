// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_track.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarTrackCollection on Isar {
  IsarCollection<IsarTrack> get isarTracks => this.collection();
}

const IsarTrackSchema = CollectionSchema(
  name: r'IsarTrack',
  id: 4152992676124368771,
  properties: {
    r'albumId': PropertySchema(
      id: 0,
      name: r'albumId',
      type: IsarType.string,
    ),
    r'artistsIds': PropertySchema(
      id: 1,
      name: r'artistsIds',
      type: IsarType.stringList,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'isExplicit': PropertySchema(
      id: 4,
      name: r'isExplicit',
      type: IsarType.bool,
    ),
    r'isarAudioInfoSet': PropertySchema(
      id: 5,
      name: r'isarAudioInfoSet',
      type: IsarType.object,
      target: r'IsarAudioInfoSet',
    ),
    r'isarDuration': PropertySchema(
      id: 6,
      name: r'isarDuration',
      type: IsarType.object,
      target: r'IsarDuration',
    ),
    r'isarThumbnails': PropertySchema(
      id: 7,
      name: r'isarThumbnails',
      type: IsarType.object,
      target: r'IsarThumbnailsSet',
    ),
    r'source': PropertySchema(
      id: 8,
      name: r'source',
      type: IsarType.byte,
      enumMap: _IsarTracksourceEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 9,
      name: r'title',
      type: IsarType.string,
    ),
    r'views': PropertySchema(
      id: 10,
      name: r'views',
      type: IsarType.long,
    ),
    r'year': PropertySchema(
      id: 11,
      name: r'year',
      type: IsarType.string,
    )
  },
  estimateSize: _isarTrackEstimateSize,
  serialize: _isarTrackSerialize,
  deserialize: _isarTrackDeserialize,
  deserializeProp: _isarTrackDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'IsarThumbnailsSet': IsarThumbnailsSetSchema,
    r'IsarThumbnail': IsarThumbnailSchema,
    r'IsarAudioInfoSet': IsarAudioInfoSetSchema,
    r'IsarTrackAudioInfo': IsarTrackAudioInfoSchema,
    r'IsarDuration': IsarDurationSchema
  },
  getId: _isarTrackGetId,
  getLinks: _isarTrackGetLinks,
  attach: _isarTrackAttach,
  version: '3.1.0+1',
);

int _isarTrackEstimateSize(
  IsarTrack object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.albumId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.artistsIds.length * 3;
  {
    for (var i = 0; i < object.artistsIds.length; i++) {
      final value = object.artistsIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.isarAudioInfoSet;
    if (value != null) {
      bytesCount += 3 +
          IsarAudioInfoSetSchema.estimateSize(
              value, allOffsets[IsarAudioInfoSet]!, allOffsets);
    }
  }
  bytesCount += 3 +
      IsarDurationSchema.estimateSize(
          object.isarDuration, allOffsets[IsarDuration]!, allOffsets);
  bytesCount += 3 +
      IsarThumbnailsSetSchema.estimateSize(
          object.isarThumbnails, allOffsets[IsarThumbnailsSet]!, allOffsets);
  bytesCount += 3 + object.title.length * 3;
  {
    final value = object.year;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarTrackSerialize(
  IsarTrack object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.albumId);
  writer.writeStringList(offsets[1], object.artistsIds);
  writer.writeString(offsets[2], object.category);
  writer.writeString(offsets[3], object.id);
  writer.writeBool(offsets[4], object.isExplicit);
  writer.writeObject<IsarAudioInfoSet>(
    offsets[5],
    allOffsets,
    IsarAudioInfoSetSchema.serialize,
    object.isarAudioInfoSet,
  );
  writer.writeObject<IsarDuration>(
    offsets[6],
    allOffsets,
    IsarDurationSchema.serialize,
    object.isarDuration,
  );
  writer.writeObject<IsarThumbnailsSet>(
    offsets[7],
    allOffsets,
    IsarThumbnailsSetSchema.serialize,
    object.isarThumbnails,
  );
  writer.writeByte(offsets[8], object.source.index);
  writer.writeString(offsets[9], object.title);
  writer.writeLong(offsets[10], object.views);
  writer.writeString(offsets[11], object.year);
}

IsarTrack _isarTrackDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarTrack(
    albumId: reader.readStringOrNull(offsets[0]),
    artistsIds: reader.readStringList(offsets[1]) ?? const [],
    category: reader.readStringOrNull(offsets[2]),
    id: reader.readStringOrNull(offsets[3]) ?? '',
    isExplicit: reader.readBoolOrNull(offsets[4]) ?? false,
    isarAudioInfoSet: reader.readObjectOrNull<IsarAudioInfoSet>(
      offsets[5],
      IsarAudioInfoSetSchema.deserialize,
      allOffsets,
    ),
    isarDuration: reader.readObjectOrNull<IsarDuration>(
          offsets[6],
          IsarDurationSchema.deserialize,
          allOffsets,
        ) ??
        const IsarDuration(),
    isarId: id,
    isarThumbnails: reader.readObjectOrNull<IsarThumbnailsSet>(
          offsets[7],
          IsarThumbnailsSetSchema.deserialize,
          allOffsets,
        ) ??
        const IsarThumbnailsSet(),
    source: _IsarTracksourceValueEnumMap[reader.readByteOrNull(offsets[8])] ??
        MusicSource.youtube,
    title: reader.readStringOrNull(offsets[9]) ?? '',
    views: reader.readLongOrNull(offsets[10]),
    year: reader.readStringOrNull(offsets[11]),
  );
  return object;
}

P _isarTrackDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? const []) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readObjectOrNull<IsarAudioInfoSet>(
        offset,
        IsarAudioInfoSetSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (reader.readObjectOrNull<IsarDuration>(
            offset,
            IsarDurationSchema.deserialize,
            allOffsets,
          ) ??
          const IsarDuration()) as P;
    case 7:
      return (reader.readObjectOrNull<IsarThumbnailsSet>(
            offset,
            IsarThumbnailsSetSchema.deserialize,
            allOffsets,
          ) ??
          const IsarThumbnailsSet()) as P;
    case 8:
      return (_IsarTracksourceValueEnumMap[reader.readByteOrNull(offset)] ??
          MusicSource.youtube) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarTracksourceEnumValueMap = {
  'youtube': 0,
  'spotify': 1,
  'local': 2,
  'unknown': 3,
};
const _IsarTracksourceValueEnumMap = {
  0: MusicSource.youtube,
  1: MusicSource.spotify,
  2: MusicSource.local,
  3: MusicSource.unknown,
};

Id _isarTrackGetId(IsarTrack object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarTrackGetLinks(IsarTrack object) {
  return [];
}

void _isarTrackAttach(IsarCollection<dynamic> col, Id id, IsarTrack object) {
  object.isarId = id;
}

extension IsarTrackByIndex on IsarCollection<IsarTrack> {
  Future<IsarTrack?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  IsarTrack? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<IsarTrack?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<IsarTrack?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(IsarTrack object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(IsarTrack object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<IsarTrack> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<IsarTrack> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension IsarTrackQueryWhereSort
    on QueryBuilder<IsarTrack, IsarTrack, QWhere> {
  QueryBuilder<IsarTrack, IsarTrack, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarTrackQueryWhere
    on QueryBuilder<IsarTrack, IsarTrack, QWhereClause> {
  QueryBuilder<IsarTrack, IsarTrack, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterWhereClause> idNotEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarTrackQueryFilter
    on QueryBuilder<IsarTrack, IsarTrack, QFilterCondition> {
  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> albumIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      albumIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artistsIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artistsIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artistsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'artistsIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'artistsIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'artistsIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'artistsIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'artistsIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      artistsIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'artistsIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isExplicitEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExplicit',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      isarAudioInfoSetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarAudioInfoSet',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition>
      isarAudioInfoSetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarAudioInfoSet',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> sourceEqualTo(
      MusicSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> sourceGreaterThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> sourceLessThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> sourceBetween(
    MusicSource lower,
    MusicSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> viewsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'views',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> viewsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'views',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> viewsEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'views',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> viewsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'views',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> viewsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'views',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> viewsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'views',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'year',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'year',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'year',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'year',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'year',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'year',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'year',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'year',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> yearIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'year',
        value: '',
      ));
    });
  }
}

extension IsarTrackQueryObject
    on QueryBuilder<IsarTrack, IsarTrack, QFilterCondition> {
  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarAudioInfoSet(
      FilterQuery<IsarAudioInfoSet> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarAudioInfoSet');
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarDuration(
      FilterQuery<IsarDuration> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarDuration');
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterFilterCondition> isarThumbnails(
      FilterQuery<IsarThumbnailsSet> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarThumbnails');
    });
  }
}

extension IsarTrackQueryLinks
    on QueryBuilder<IsarTrack, IsarTrack, QFilterCondition> {}

extension IsarTrackQuerySortBy on QueryBuilder<IsarTrack, IsarTrack, QSortBy> {
  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByIsExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByIsExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByViews() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'views', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByViewsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'views', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension IsarTrackQuerySortThenBy
    on QueryBuilder<IsarTrack, IsarTrack, QSortThenBy> {
  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByIsExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByIsExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByViews() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'views', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByViewsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'views', Sort.desc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension IsarTrackQueryWhereDistinct
    on QueryBuilder<IsarTrack, IsarTrack, QDistinct> {
  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctByAlbumId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctByArtistsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artistsIds');
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctByIsExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExplicit');
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source');
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctByViews() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'views');
    });
  }

  QueryBuilder<IsarTrack, IsarTrack, QDistinct> distinctByYear(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year', caseSensitive: caseSensitive);
    });
  }
}

extension IsarTrackQueryProperty
    on QueryBuilder<IsarTrack, IsarTrack, QQueryProperty> {
  QueryBuilder<IsarTrack, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IsarTrack, String?, QQueryOperations> albumIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumId');
    });
  }

  QueryBuilder<IsarTrack, List<String>, QQueryOperations> artistsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artistsIds');
    });
  }

  QueryBuilder<IsarTrack, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<IsarTrack, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarTrack, bool, QQueryOperations> isExplicitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExplicit');
    });
  }

  QueryBuilder<IsarTrack, IsarAudioInfoSet?, QQueryOperations>
      isarAudioInfoSetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarAudioInfoSet');
    });
  }

  QueryBuilder<IsarTrack, IsarDuration, QQueryOperations>
      isarDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarDuration');
    });
  }

  QueryBuilder<IsarTrack, IsarThumbnailsSet, QQueryOperations>
      isarThumbnailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarThumbnails');
    });
  }

  QueryBuilder<IsarTrack, MusicSource, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<IsarTrack, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<IsarTrack, int?, QQueryOperations> viewsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'views');
    });
  }

  QueryBuilder<IsarTrack, String?, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
