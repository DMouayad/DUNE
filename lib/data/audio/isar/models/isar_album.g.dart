// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_album.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarAlbumCollection on Isar {
  IsarCollection<IsarAlbum> get isarAlbums => this.collection();
}

const IsarAlbumSchema = CollectionSchema(
  name: r'IsarAlbum',
  id: 8073605566212355973,
  properties: {
    r'albumArtistId': PropertySchema(
      id: 0,
      name: r'albumArtistId',
      type: IsarType.string,
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
    r'duration': PropertySchema(
      id: 3,
      name: r'duration',
      type: IsarType.string,
    ),
    r'featuredArtistsIds': PropertySchema(
      id: 4,
      name: r'featuredArtistsIds',
      type: IsarType.stringList,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'isExplicit': PropertySchema(
      id: 6,
      name: r'isExplicit',
      type: IsarType.bool,
    ),
    r'isarThumbnails': PropertySchema(
      id: 7,
      name: r'isarThumbnails',
      type: IsarType.object,
      target: r'IsarThumbnailsSet',
    ),
    r'musicSource': PropertySchema(
      id: 8,
      name: r'musicSource',
      type: IsarType.byte,
      enumMap: _IsarAlbummusicSourceEnumValueMap,
    ),
    r'releaseDate': PropertySchema(
      id: 9,
      name: r'releaseDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 10,
      name: r'title',
      type: IsarType.string,
    ),
    r'tracksIds': PropertySchema(
      id: 11,
      name: r'tracksIds',
      type: IsarType.stringList,
    ),
    r'type': PropertySchema(
      id: 12,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _isarAlbumEstimateSize,
  serialize: _isarAlbumSerialize,
  deserialize: _isarAlbumDeserialize,
  deserializeProp: _isarAlbumDeserializeProp,
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
  getId: _isarAlbumGetId,
  getLinks: _isarAlbumGetLinks,
  attach: _isarAlbumAttach,
  version: '3.1.0+1',
);

int _isarAlbumEstimateSize(
  IsarAlbum object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.albumArtistId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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
  {
    final value = object.duration;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.featuredArtistsIds.length * 3;
  {
    for (var i = 0; i < object.featuredArtistsIds.length; i++) {
      final value = object.featuredArtistsIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 +
      IsarThumbnailsSetSchema.estimateSize(
          object.isarThumbnails, allOffsets[IsarThumbnailsSet]!, allOffsets);
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.tracksIds.length * 3;
  {
    for (var i = 0; i < object.tracksIds.length; i++) {
      final value = object.tracksIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarAlbumSerialize(
  IsarAlbum object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.albumArtistId);
  writer.writeString(offsets[1], object.browseId);
  writer.writeString(offsets[2], object.category);
  writer.writeString(offsets[3], object.duration);
  writer.writeStringList(offsets[4], object.featuredArtistsIds);
  writer.writeString(offsets[5], object.id);
  writer.writeBool(offsets[6], object.isExplicit);
  writer.writeObject<IsarThumbnailsSet>(
    offsets[7],
    allOffsets,
    IsarThumbnailsSetSchema.serialize,
    object.isarThumbnails,
  );
  writer.writeByte(offsets[8], object.musicSource.index);
  writer.writeDateTime(offsets[9], object.releaseDate);
  writer.writeString(offsets[10], object.title);
  writer.writeStringList(offsets[11], object.tracksIds);
  writer.writeString(offsets[12], object.type);
}

IsarAlbum _isarAlbumDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarAlbum(
    albumArtistId: reader.readStringOrNull(offsets[0]),
    browseId: reader.readStringOrNull(offsets[1]),
    category: reader.readStringOrNull(offsets[2]),
    duration: reader.readStringOrNull(offsets[3]),
    featuredArtistsIds: reader.readStringList(offsets[4]) ?? const [],
    id: reader.readStringOrNull(offsets[5]),
    isExplicit: reader.readBoolOrNull(offsets[6]) ?? false,
    isarId: id,
    isarThumbnails: reader.readObjectOrNull<IsarThumbnailsSet>(
          offsets[7],
          IsarThumbnailsSetSchema.deserialize,
          allOffsets,
        ) ??
        const IsarThumbnailsSet(),
    musicSource:
        _IsarAlbummusicSourceValueEnumMap[reader.readByteOrNull(offsets[8])] ??
            MusicSource.unknown,
    releaseDate: reader.readDateTimeOrNull(offsets[9]),
    title: reader.readStringOrNull(offsets[10]) ?? '',
    tracksIds: reader.readStringList(offsets[11]) ?? const [],
    type: reader.readStringOrNull(offsets[12]),
  );
  return object;
}

P _isarAlbumDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? const []) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readObjectOrNull<IsarThumbnailsSet>(
            offset,
            IsarThumbnailsSetSchema.deserialize,
            allOffsets,
          ) ??
          const IsarThumbnailsSet()) as P;
    case 8:
      return (_IsarAlbummusicSourceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MusicSource.unknown) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readStringList(offset) ?? const []) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarAlbummusicSourceEnumValueMap = {
  'youtube': 0,
  'spotify': 1,
  'local': 2,
  'unknown': 3,
};
const _IsarAlbummusicSourceValueEnumMap = {
  0: MusicSource.youtube,
  1: MusicSource.spotify,
  2: MusicSource.local,
  3: MusicSource.unknown,
};

Id _isarAlbumGetId(IsarAlbum object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarAlbumGetLinks(IsarAlbum object) {
  return [];
}

void _isarAlbumAttach(IsarCollection<dynamic> col, Id id, IsarAlbum object) {
  object.isarId = id;
}

extension IsarAlbumByIndex on IsarCollection<IsarAlbum> {
  Future<IsarAlbum?> getByIdMusicSource(String? id, MusicSource musicSource) {
    return getByIndex(r'id_musicSource', [id, musicSource]);
  }

  IsarAlbum? getByIdMusicSourceSync(String? id, MusicSource musicSource) {
    return getByIndexSync(r'id_musicSource', [id, musicSource]);
  }

  Future<bool> deleteByIdMusicSource(String? id, MusicSource musicSource) {
    return deleteByIndex(r'id_musicSource', [id, musicSource]);
  }

  bool deleteByIdMusicSourceSync(String? id, MusicSource musicSource) {
    return deleteByIndexSync(r'id_musicSource', [id, musicSource]);
  }

  Future<List<IsarAlbum?>> getAllByIdMusicSource(
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

  List<IsarAlbum?> getAllByIdMusicSourceSync(
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

  Future<Id> putByIdMusicSource(IsarAlbum object) {
    return putByIndex(r'id_musicSource', object);
  }

  Id putByIdMusicSourceSync(IsarAlbum object, {bool saveLinks = true}) {
    return putByIndexSync(r'id_musicSource', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByIdMusicSource(List<IsarAlbum> objects) {
    return putAllByIndex(r'id_musicSource', objects);
  }

  List<Id> putAllByIdMusicSourceSync(List<IsarAlbum> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id_musicSource', objects, saveLinks: saveLinks);
  }
}

extension IsarAlbumQueryWhereSort
    on QueryBuilder<IsarAlbum, IsarAlbum, QWhere> {
  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhere> anyMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'musicSource'),
      );
    });
  }
}

extension IsarAlbumQueryWhere
    on QueryBuilder<IsarAlbum, IsarAlbum, QWhereClause> {
  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> musicSourceEqualTo(
      MusicSource musicSource) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'musicSource',
        value: [musicSource],
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> musicSourceNotEqualTo(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> musicSourceGreaterThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> musicSourceLessThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> musicSourceBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause>
      idIsNullAnyMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id_musicSource',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> idEqualToAnyMusicSource(
      String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id_musicSource',
        value: [id],
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause> idMusicSourceEqualTo(
      String? id, MusicSource musicSource) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id_musicSource',
        value: [id, musicSource],
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterWhereClause>
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

extension IsarAlbumQueryFilter
    on QueryBuilder<IsarAlbum, IsarAlbum, QFilterCondition> {
  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumArtistId',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumArtistId',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArtistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumArtistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumArtistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumArtistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumArtistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumArtistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumArtistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumArtistId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArtistId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      albumArtistIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumArtistId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'browseId',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      browseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'browseId',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdEqualTo(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdGreaterThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdLessThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdStartsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdEndsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdContains(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdMatches(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> browseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'browseId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      browseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'browseId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryEqualTo(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryGreaterThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryLessThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryStartsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryEndsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryContains(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryMatches(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      durationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'duration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'duration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'duration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'duration',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> durationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      durationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'duration',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'featuredArtistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'featuredArtistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'featuredArtistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'featuredArtistsIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'featuredArtistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'featuredArtistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'featuredArtistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'featuredArtistsIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'featuredArtistsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'featuredArtistsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'featuredArtistsIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'featuredArtistsIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'featuredArtistsIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'featuredArtistsIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'featuredArtistsIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      featuredArtistsIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'featuredArtistsIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idContains(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idMatches(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isExplicitEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExplicit',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> musicSourceEqualTo(
      MusicSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'musicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> musicSourceLessThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> musicSourceBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      releaseDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      releaseDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> releaseDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'releaseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      releaseDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'releaseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> releaseDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'releaseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> releaseDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'releaseDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleGreaterThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleContains(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleMatches(
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      tracksIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tracksIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      tracksIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tracksIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      tracksIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tracksIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
      tracksIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tracksIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> tracksIdsIsEmpty() {
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition>
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

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension IsarAlbumQueryObject
    on QueryBuilder<IsarAlbum, IsarAlbum, QFilterCondition> {
  QueryBuilder<IsarAlbum, IsarAlbum, QAfterFilterCondition> isarThumbnails(
      FilterQuery<IsarThumbnailsSet> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarThumbnails');
    });
  }
}

extension IsarAlbumQueryLinks
    on QueryBuilder<IsarAlbum, IsarAlbum, QFilterCondition> {}

extension IsarAlbumQuerySortBy on QueryBuilder<IsarAlbum, IsarAlbum, QSortBy> {
  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByAlbumArtistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistId', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByAlbumArtistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistId', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByBrowseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByBrowseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByIsExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByIsExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByMusicSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension IsarAlbumQuerySortThenBy
    on QueryBuilder<IsarAlbum, IsarAlbum, QSortThenBy> {
  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByAlbumArtistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistId', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByAlbumArtistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistId', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByBrowseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByBrowseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'browseId', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByIsExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByIsExplicitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExplicit', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByMusicSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicSource', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension IsarAlbumQueryWhereDistinct
    on QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> {
  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByAlbumArtistId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumArtistId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByBrowseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'browseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByDuration(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByFeaturedArtistsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'featuredArtistsIds');
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByIsExplicit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExplicit');
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'musicSource');
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'releaseDate');
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByTracksIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tracksIds');
    });
  }

  QueryBuilder<IsarAlbum, IsarAlbum, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension IsarAlbumQueryProperty
    on QueryBuilder<IsarAlbum, IsarAlbum, QQueryProperty> {
  QueryBuilder<IsarAlbum, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IsarAlbum, String?, QQueryOperations> albumArtistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumArtistId');
    });
  }

  QueryBuilder<IsarAlbum, String?, QQueryOperations> browseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'browseId');
    });
  }

  QueryBuilder<IsarAlbum, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<IsarAlbum, String?, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<IsarAlbum, List<String>, QQueryOperations>
      featuredArtistsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'featuredArtistsIds');
    });
  }

  QueryBuilder<IsarAlbum, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarAlbum, bool, QQueryOperations> isExplicitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExplicit');
    });
  }

  QueryBuilder<IsarAlbum, IsarThumbnailsSet, QQueryOperations>
      isarThumbnailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarThumbnails');
    });
  }

  QueryBuilder<IsarAlbum, MusicSource, QQueryOperations> musicSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'musicSource');
    });
  }

  QueryBuilder<IsarAlbum, DateTime?, QQueryOperations> releaseDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'releaseDate');
    });
  }

  QueryBuilder<IsarAlbum, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<IsarAlbum, List<String>, QQueryOperations> tracksIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tracksIds');
    });
  }

  QueryBuilder<IsarAlbum, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
