// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_artist.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarArtistCollection on Isar {
  IsarCollection<IsarArtist> get isarArtists => this.collection();
}

const IsarArtistSchema = CollectionSchema(
  name: r'IsarArtist',
  id: -7076447970192203452,
  properties: {
    r'albumsIds': PropertySchema(
      id: 0,
      name: r'albumsIds',
      type: IsarType.stringList,
    ),
    r'browseId': PropertySchema(
      id: 1,
      name: r'browseId',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'isarThumbnails': PropertySchema(
      id: 5,
      name: r'isarThumbnails',
      type: IsarType.object,
      target: r'IsarThumbnailsSet',
    ),
    r'musicSource': PropertySchema(
      id: 6,
      name: r'musicSource',
      type: IsarType.byte,
      enumMap: _IsarArtistmusicSourceEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'radioId': PropertySchema(
      id: 8,
      name: r'radioId',
      type: IsarType.string,
    ),
    r'shuffleId': PropertySchema(
      id: 9,
      name: r'shuffleId',
      type: IsarType.string,
    ),
    r'tracksIds': PropertySchema(
      id: 10,
      name: r'tracksIds',
      type: IsarType.stringList,
    )
  },
  estimateSize: _isarArtistEstimateSize,
  serialize: _isarArtistSerialize,
  deserialize: _isarArtistDeserialize,
  deserializeProp: _isarArtistDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'musicSource': IndexSchema(
      id: -7444336687380187352,
      name: r'musicSource',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'musicSource',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'id_musicSource': IndexSchema(
      id: -6463270181635692098,
      name: r'id_musicSource',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'musicSource',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'IsarThumbnailsSet': IsarThumbnailsSetSchema,
    r'IsarThumbnail': IsarThumbnailSchema
  },
  getId: _isarArtistGetId,
  getLinks: _isarArtistGetLinks,
  attach: _isarArtistAttach,
  version: '3.1.0+1',
);

int _isarArtistEstimateSize(
  IsarArtist object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.albumsIds.length * 3;
  {
    for (var i = 0; i < object.albumsIds.length; i++) {
      final value = object.albumsIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.browseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.description.length * 3;
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 +
      IsarThumbnailsSetSchema.estimateSize(
          object.isarThumbnails, allOffsets[IsarThumbnailsSet]!, allOffsets);
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.radioId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shuffleId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tracksIds.length * 3;
  {
    for (var i = 0; i < object.tracksIds.length; i++) {
      final value = object.tracksIds[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _isarArtistSerialize(
  IsarArtist object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.albumsIds);
  writer.writeString(offsets[1], object.browseId);
  writer.writeString(offsets[2], object.category);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.id);
  writer.writeObject<IsarThumbnailsSet>(
    offsets[5],
    allOffsets,
    IsarThumbnailsSetSchema.serialize,
    object.isarThumbnails,
  );
  writer.writeByte(offsets[6], object.musicSource.index);
  writer.writeString(offsets[7], object.name);
  writer.writeString(offsets[8], object.radioId);
  writer.writeString(offsets[9], object.shuffleId);
  writer.writeStringList(offsets[10], object.tracksIds);
}

IsarArtist _isarArtistDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarArtist(
    albumsIds: reader.readStringList(offsets[0]) ?? const [],
    browseId: reader.readStringOrNull(offsets[1]),
    category: reader.readStringOrNull(offsets[2]),
    description: reader.readStringOrNull(offsets[3]) ?? '',
    id: reader.readStringOrNull(offsets[4]),
    isarId: id,
    isarThumbnails: reader.readObjectOrNull<IsarThumbnailsSet>(
          offsets[5],
          IsarThumbnailsSetSchema.deserialize,
          allOffsets,
        ) ??
        const IsarThumbnailsSet(),
    musicSource:
        _IsarArtistmusicSourceValueEnumMap[reader.readByteOrNull(offsets[6])] ??
            MusicSource.unknown,
    name: reader.readStringOrNull(offsets[7]),
    radioId: reader.readStringOrNull(offsets[8]),
    shuffleId: reader.readStringOrNull(offsets[9]),
    tracksIds: reader.readStringList(offsets[10]) ?? const [],
  );
  return object;
}

P _isarArtistDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? const []) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<IsarThumbnailsSet>(
            offset,
            IsarThumbnailsSetSchema.deserialize,
            allOffsets,
          ) ??
          const IsarThumbnailsSet()) as P;
    case 6:
      return (_IsarArtistmusicSourceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MusicSource.unknown) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarArtistmusicSourceEnumValueMap = {
  'youtube': 0,
  'spotify': 1,
  'local': 2,
  'unknown': 3,
};
const _IsarArtistmusicSourceValueEnumMap = {
  0: MusicSource.youtube,
  1: MusicSource.spotify,
  2: MusicSource.local,
  3: MusicSource.unknown,
};

Id _isarArtistGetId(IsarArtist object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarArtistGetLinks(IsarArtist object) {
  return [];
}

void _isarArtistAttach(IsarCollection<dynamic> col, Id id, IsarArtist object) {
  object.isarId = id;
}

extension IsarArtistByIndex on IsarCollection<IsarArtist> {
  Future<IsarArtist?> getByIdMusicSource(String? id, MusicSource musicSource) {
    return getByIndex(r'id_musicSource', [id, musicSource]);
  }

  IsarArtist? getByIdMusicSourceSync(String? id, MusicSource musicSource) {
    return getByIndexSync(r'id_musicSource', [id, musicSource]);
  }

  Future<bool> deleteByIdMusicSource(String? id, MusicSource musicSource) {
    return deleteByIndex(r'id_musicSource', [id, musicSource]);
  }

  bool deleteByIdMusicSourceSync(String? id, MusicSource musicSource) {
    return deleteByIndexSync(r'id_musicSource', [id, musicSource]);
  }

  Future<List<IsarArtist?>> getAllByIdMusicSource(
      List<String?> idValues, List<MusicSource> musicSourceValues) {
    final len = idValues.length;
    assert(musicSourceValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([idValues[i], musicSourceValues[i]]);
    }

    return getAllByIndex(r'id_musicSource', values);
  }

  List<IsarArtist?> getAllByIdMusicSourceSync(
      List<String?> idValues, List<MusicSource> musicSourceValues) {
    final len = idValues.length;
    assert(musicSourceValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([idValues[i], musicSourceValues[i]]);
    }

    return getAllByIndexSync(r'id_musicSource', values);
  }

  Future<int> deleteAllByIdMusicSource(
      List<String?> idValues, List<MusicSource> musicSourceValues) {
    final len = idValues.length;
    assert(musicSourceValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([idValues[i], musicSourceValues[i]]);
    }

    return deleteAllByIndex(r'id_musicSource', values);
  }

  int deleteAllByIdMusicSourceSync(
      List<String?> idValues, List<MusicSource> musicSourceValues) {
    final len = idValues.length;
    assert(musicSourceValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([idValues[i], musicSourceValues[i]]);
    }

    return deleteAllByIndexSync(r'id_musicSource', values);
  }

  Future<Id> putByIdMusicSource(IsarArtist object) {
    return putByIndex(r'id_musicSource', object);
  }

  Id putByIdMusicSourceSync(IsarArtist object, {bool saveLinks = true}) {
    return putByIndexSync(r'id_musicSource', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByIdMusicSource(List<IsarArtist> objects) {
    return putAllByIndex(r'id_musicSource', objects);
  }

  List<Id> putAllByIdMusicSourceSync(List<IsarArtist> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id_musicSource', objects, saveLinks: saveLinks);
  }
}

extension IsarArtistQueryWhereSort
    on QueryBuilder<IsarArtist, IsarArtist, QWhere> {
  QueryBuilder<IsarArtist, IsarArtist, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhere> anyMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'musicSource'),
      );
    });
  }
}

extension IsarArtistQueryWhere
    on QueryBuilder<IsarArtist, IsarArtist, QWhereClause> {
  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> musicSourceEqualTo(
      MusicSource musicSource) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'musicSource',
        value: [musicSource],
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> musicSourceNotEqualTo(
      MusicSource musicSource) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'musicSource',
              lower: [],
              upper: [musicSource],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'musicSource',
              lower: [musicSource],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'musicSource',
              lower: [musicSource],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'musicSource',
              lower: [],
              upper: [musicSource],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      musicSourceGreaterThan(
    MusicSource musicSource, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'musicSource',
        lower: [musicSource],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> musicSourceLessThan(
    MusicSource musicSource, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'musicSource',
        lower: [],
        upper: [musicSource],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> musicSourceBetween(
    MusicSource lowerMusicSource,
    MusicSource upperMusicSource, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'musicSource',
        lower: [lowerMusicSource],
        includeLower: includeLower,
        upper: [upperMusicSource],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idIsNullAnyMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id_musicSource',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idIsNotNullAnyMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id_musicSource',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idEqualToAnyMusicSource(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id_musicSource',
        value: [id],
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idNotEqualToAnyMusicSource(String? id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause> idMusicSourceEqualTo(
      String? id, MusicSource musicSource) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id_musicSource',
        value: [id, musicSource],
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idEqualToMusicSourceNotEqualTo(String? id, MusicSource musicSource) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [id],
              upper: [id, musicSource],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [id, musicSource],
              includeLower: false,
              upper: [id],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [id, musicSource],
              includeLower: false,
              upper: [id],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id_musicSource',
              lower: [id],
              upper: [id, musicSource],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idEqualToMusicSourceGreaterThan(
    String? id,
    MusicSource musicSource, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id_musicSource',
        lower: [id, musicSource],
        includeLower: include,
        upper: [id],
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idEqualToMusicSourceLessThan(
    String? id,
    MusicSource musicSource, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id_musicSource',
        lower: [id],
        upper: [id, musicSource],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterWhereClause>
      idEqualToMusicSourceBetween(
    String? id,
    MusicSource lowerMusicSource,
    MusicSource upperMusicSource, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id_musicSource',
        lower: [id, lowerMusicSource],
        includeLower: includeLower,
        upper: [id, upperMusicSource],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarArtistQueryFilter
    on QueryBuilder<IsarArtist, IsarArtist, QFilterCondition> {
  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumsIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumsIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'albumsIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'albumsIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'albumsIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'albumsIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'albumsIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      albumsIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'albumsIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> browseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'browseId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      browseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'browseId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> browseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'browseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      browseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'browseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> browseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'browseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> browseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'browseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      browseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'browseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> browseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'browseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> browseIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'browseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> browseIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'browseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      browseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'browseId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      browseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'browseId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> categoryEqualTo(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      categoryGreaterThan(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> categoryLessThan(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> categoryBetween(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      categoryStartsWith(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> categoryEndsWith(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> categoryContains(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> categoryMatches(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idEqualTo(
    String? value, {
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idGreaterThan(
    String? value, {
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idLessThan(
    String? value, {
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idContains(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idMatches(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      musicSourceEqualTo(MusicSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'musicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
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

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'radioId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      radioIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'radioId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'radioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      radioIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'radioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'radioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'radioId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'radioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'radioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'radioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'radioId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> radioIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'radioId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      radioIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'radioId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      shuffleIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shuffleId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      shuffleIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shuffleId',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> shuffleIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shuffleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      shuffleIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shuffleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> shuffleIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shuffleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> shuffleIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shuffleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      shuffleIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shuffleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> shuffleIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shuffleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> shuffleIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shuffleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> shuffleIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shuffleId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      shuffleIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shuffleId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      shuffleIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shuffleId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tracksIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tracksIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tracksIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tracksIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tracksIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tracksIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tracksIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tracksIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tracksIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tracksIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tracksIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tracksIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tracksIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tracksIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tracksIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition>
      tracksIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tracksIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension IsarArtistQueryObject
    on QueryBuilder<IsarArtist, IsarArtist, QFilterCondition> {
  QueryBuilder<IsarArtist, IsarArtist, QAfterFilterCondition> isarThumbnails(
      FilterQuery<IsarThumbnailsSet> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarThumbnails');
    });
  }
}

extension IsarArtistQueryLinks
    on QueryBuilder<IsarArtist, IsarArtist, QFilterCondition> {}

extension IsarArtistQuerySortBy
    on QueryBuilder<IsarArtist, IsarArtist, QSortBy> {
  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByBrowseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByBrowseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByMusicSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByRadioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radioId', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByRadioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radioId', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByShuffleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shuffleId', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> sortByShuffleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shuffleId', Sort.desc);
    });
  }
}

extension IsarArtistQuerySortThenBy
    on QueryBuilder<IsarArtist, IsarArtist, QSortThenBy> {
  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByBrowseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByBrowseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByMusicSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByRadioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radioId', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByRadioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radioId', Sort.desc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByShuffleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shuffleId', Sort.asc);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QAfterSortBy> thenByShuffleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shuffleId', Sort.desc);
    });
  }
}

extension IsarArtistQueryWhereDistinct
    on QueryBuilder<IsarArtist, IsarArtist, QDistinct> {
  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByAlbumsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumsIds');
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByBrowseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'browseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'musicSource');
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByRadioId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'radioId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByShuffleId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shuffleId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarArtist, IsarArtist, QDistinct> distinctByTracksIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tracksIds');
    });
  }
}

extension IsarArtistQueryProperty
    on QueryBuilder<IsarArtist, IsarArtist, QQueryProperty> {
  QueryBuilder<IsarArtist, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IsarArtist, List<String>, QQueryOperations> albumsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumsIds');
    });
  }

  QueryBuilder<IsarArtist, String?, QQueryOperations> browseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'browseId');
    });
  }

  QueryBuilder<IsarArtist, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<IsarArtist, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<IsarArtist, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarArtist, IsarThumbnailsSet, QQueryOperations>
      isarThumbnailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarThumbnails');
    });
  }

  QueryBuilder<IsarArtist, MusicSource, QQueryOperations>
      musicSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'musicSource');
    });
  }

  QueryBuilder<IsarArtist, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<IsarArtist, String?, QQueryOperations> radioIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'radioId');
    });
  }

  QueryBuilder<IsarArtist, String?, QQueryOperations> shuffleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shuffleId');
    });
  }

  QueryBuilder<IsarArtist, List<String>, QQueryOperations> tracksIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tracksIds');
    });
  }
}
