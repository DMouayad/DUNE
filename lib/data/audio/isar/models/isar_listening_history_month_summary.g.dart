// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_listening_history_month_summary.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarListeningHistoryMonthSummaryCollection on Isar {
  IsarCollection<IsarListeningHistoryMonthSummary>
      get isarListeningHistoryMonthSummarys => this.collection();
}

const IsarListeningHistoryMonthSummarySchema = CollectionSchema(
  name: r'IsarListeningHistoryMonthSummary',
  id: 1491424169073337679,
  properties: {
    r'artistsCount': PropertySchema(
      id: 0,
      name: r'artistsCount',
      type: IsarType.long,
    ),
    r'isarTopArtists': PropertySchema(
      id: 1,
      name: r'isarTopArtists',
      type: IsarType.objectList,
      target: r'IsarMonthListeningHistoryArtistSummary',
    ),
    r'isarTopTracks': PropertySchema(
      id: 2,
      name: r'isarTopTracks',
      type: IsarType.objectList,
      target: r'IsarMonthListeningHistoryTrackSummary',
    ),
    r'listeningMinutesTotal': PropertySchema(
      id: 3,
      name: r'listeningMinutesTotal',
      type: IsarType.long,
    ),
    r'month': PropertySchema(
      id: 4,
      name: r'month',
      type: IsarType.long,
    ),
    r'mostListenedOnDay': PropertySchema(
      id: 5,
      name: r'mostListenedOnDay',
      type: IsarType.dateTime,
    ),
    r'tracksCount': PropertySchema(
      id: 6,
      name: r'tracksCount',
      type: IsarType.long,
    ),
    r'tracksCountIncreasePercentage': PropertySchema(
      id: 7,
      name: r'tracksCountIncreasePercentage',
      type: IsarType.double,
    ),
    r'tracksRepetitionPercent': PropertySchema(
      id: 8,
      name: r'tracksRepetitionPercent',
      type: IsarType.long,
    ),
    r'year': PropertySchema(
      id: 9,
      name: r'year',
      type: IsarType.long,
    )
  },
  estimateSize: _isarListeningHistoryMonthSummaryEstimateSize,
  serialize: _isarListeningHistoryMonthSummarySerialize,
  deserialize: _isarListeningHistoryMonthSummaryDeserialize,
  deserializeProp: _isarListeningHistoryMonthSummaryDeserializeProp,
  idName: r'id',
  indexes: {
    r'month_year': IndexSchema(
      id: 9018924667056050055,
      name: r'month_year',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'month',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'year',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'IsarMonthListeningHistoryTrackSummary':
        IsarMonthListeningHistoryTrackSummarySchema,
    r'IsarMonthListeningHistoryArtistSummary':
        IsarMonthListeningHistoryArtistSummarySchema
  },
  getId: _isarListeningHistoryMonthSummaryGetId,
  getLinks: _isarListeningHistoryMonthSummaryGetLinks,
  attach: _isarListeningHistoryMonthSummaryAttach,
  version: '3.1.0+1',
);

int _isarListeningHistoryMonthSummaryEstimateSize(
  IsarListeningHistoryMonthSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.isarTopArtists.length * 3;
  {
    final offsets = allOffsets[IsarMonthListeningHistoryArtistSummary]!;
    for (var i = 0; i < object.isarTopArtists.length; i++) {
      final value = object.isarTopArtists[i];
      bytesCount += IsarMonthListeningHistoryArtistSummarySchema.estimateSize(
          value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.isarTopTracks.length * 3;
  {
    final offsets = allOffsets[IsarMonthListeningHistoryTrackSummary]!;
    for (var i = 0; i < object.isarTopTracks.length; i++) {
      final value = object.isarTopTracks[i];
      bytesCount += IsarMonthListeningHistoryTrackSummarySchema.estimateSize(
          value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _isarListeningHistoryMonthSummarySerialize(
  IsarListeningHistoryMonthSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.artistsCount);
  writer.writeObjectList<IsarMonthListeningHistoryArtistSummary>(
    offsets[1],
    allOffsets,
    IsarMonthListeningHistoryArtistSummarySchema.serialize,
    object.isarTopArtists,
  );
  writer.writeObjectList<IsarMonthListeningHistoryTrackSummary>(
    offsets[2],
    allOffsets,
    IsarMonthListeningHistoryTrackSummarySchema.serialize,
    object.isarTopTracks,
  );
  writer.writeLong(offsets[3], object.listeningMinutesTotal);
  writer.writeLong(offsets[4], object.month);
  writer.writeDateTime(offsets[5], object.mostListenedOnDay);
  writer.writeLong(offsets[6], object.tracksCount);
  writer.writeDouble(offsets[7], object.tracksCountIncreasePercentage);
  writer.writeLong(offsets[8], object.tracksRepetitionPercent);
  writer.writeLong(offsets[9], object.year);
}

IsarListeningHistoryMonthSummary _isarListeningHistoryMonthSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarListeningHistoryMonthSummary(
    artistsCount: reader.readLongOrNull(offsets[0]),
    id: id,
    isarTopArtists:
        reader.readObjectList<IsarMonthListeningHistoryArtistSummary>(
              offsets[1],
              IsarMonthListeningHistoryArtistSummarySchema.deserialize,
              allOffsets,
              IsarMonthListeningHistoryArtistSummary(),
            ) ??
            const [],
    isarTopTracks: reader.readObjectList<IsarMonthListeningHistoryTrackSummary>(
          offsets[2],
          IsarMonthListeningHistoryTrackSummarySchema.deserialize,
          allOffsets,
          IsarMonthListeningHistoryTrackSummary(),
        ) ??
        const [],
    listeningMinutesTotal: reader.readLongOrNull(offsets[3]) ?? 0,
    month: reader.readLongOrNull(offsets[4]),
    mostListenedOnDay: reader.readDateTimeOrNull(offsets[5]),
    tracksCount: reader.readLongOrNull(offsets[6]),
    tracksCountIncreasePercentage: reader.readDoubleOrNull(offsets[7]),
    tracksRepetitionPercent: reader.readLongOrNull(offsets[8]),
    year: reader.readLongOrNull(offsets[9]),
  );
  return object;
}

P _isarListeningHistoryMonthSummaryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<IsarMonthListeningHistoryArtistSummary>(
            offset,
            IsarMonthListeningHistoryArtistSummarySchema.deserialize,
            allOffsets,
            IsarMonthListeningHistoryArtistSummary(),
          ) ??
          const []) as P;
    case 2:
      return (reader.readObjectList<IsarMonthListeningHistoryTrackSummary>(
            offset,
            IsarMonthListeningHistoryTrackSummarySchema.deserialize,
            allOffsets,
            IsarMonthListeningHistoryTrackSummary(),
          ) ??
          const []) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarListeningHistoryMonthSummaryGetId(
    IsarListeningHistoryMonthSummary object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarListeningHistoryMonthSummaryGetLinks(
    IsarListeningHistoryMonthSummary object) {
  return [];
}

void _isarListeningHistoryMonthSummaryAttach(IsarCollection<dynamic> col, Id id,
    IsarListeningHistoryMonthSummary object) {
  object.id = id;
}

extension IsarListeningHistoryMonthSummaryByIndex
    on IsarCollection<IsarListeningHistoryMonthSummary> {
  Future<IsarListeningHistoryMonthSummary?> getByMonthYear(
      int? month, int? year) {
    return getByIndex(r'month_year', [month, year]);
  }

  IsarListeningHistoryMonthSummary? getByMonthYearSync(int? month, int? year) {
    return getByIndexSync(r'month_year', [month, year]);
  }

  Future<bool> deleteByMonthYear(int? month, int? year) {
    return deleteByIndex(r'month_year', [month, year]);
  }

  bool deleteByMonthYearSync(int? month, int? year) {
    return deleteByIndexSync(r'month_year', [month, year]);
  }

  Future<List<IsarListeningHistoryMonthSummary?>> getAllByMonthYear(
      List<int?> monthValues, List<int?> yearValues) {
    final len = monthValues.length;
    assert(
        yearValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([monthValues[i], yearValues[i]]);
    }

    return getAllByIndex(r'month_year', values);
  }

  List<IsarListeningHistoryMonthSummary?> getAllByMonthYearSync(
      List<int?> monthValues, List<int?> yearValues) {
    final len = monthValues.length;
    assert(
        yearValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([monthValues[i], yearValues[i]]);
    }

    return getAllByIndexSync(r'month_year', values);
  }

  Future<int> deleteAllByMonthYear(
      List<int?> monthValues, List<int?> yearValues) {
    final len = monthValues.length;
    assert(
        yearValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([monthValues[i], yearValues[i]]);
    }

    return deleteAllByIndex(r'month_year', values);
  }

  int deleteAllByMonthYearSync(List<int?> monthValues, List<int?> yearValues) {
    final len = monthValues.length;
    assert(
        yearValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([monthValues[i], yearValues[i]]);
    }

    return deleteAllByIndexSync(r'month_year', values);
  }

  Future<Id> putByMonthYear(IsarListeningHistoryMonthSummary object) {
    return putByIndex(r'month_year', object);
  }

  Id putByMonthYearSync(IsarListeningHistoryMonthSummary object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'month_year', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMonthYear(
      List<IsarListeningHistoryMonthSummary> objects) {
    return putAllByIndex(r'month_year', objects);
  }

  List<Id> putAllByMonthYearSync(List<IsarListeningHistoryMonthSummary> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'month_year', objects, saveLinks: saveLinks);
  }
}

extension IsarListeningHistoryMonthSummaryQueryWhereSort on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QWhere> {
  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterWhere> anyMonthYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'month_year'),
      );
    });
  }
}

extension IsarListeningHistoryMonthSummaryQueryWhere on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QWhereClause> {
  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthIsNullAnyYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'month_year',
        value: [null],
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthIsNotNullAnyYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthEqualToAnyYear(int? month) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'month_year',
        value: [month],
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthNotEqualToAnyYear(int? month) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [],
              upper: [month],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [month],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [month],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [],
              upper: [month],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthGreaterThanAnyYear(
    int? month, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [month],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterWhereClause> monthLessThanAnyYear(
    int? month, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [],
        upper: [month],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterWhereClause> monthBetweenAnyYear(
    int? lowerMonth,
    int? upperMonth, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [lowerMonth],
        includeLower: includeLower,
        upper: [upperMonth],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthEqualToYearIsNull(int? month) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'month_year',
        value: [month, null],
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthEqualToYearIsNotNull(int? month) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [month, null],
        includeLower: false,
        upper: [
          month,
        ],
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthYearEqualTo(int? month, int? year) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'month_year',
        value: [month, year],
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthEqualToYearNotEqualTo(int? month, int? year) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [month],
              upper: [month, year],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [month, year],
              includeLower: false,
              upper: [month],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [month, year],
              includeLower: false,
              upper: [month],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month_year',
              lower: [month],
              upper: [month, year],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthEqualToYearGreaterThan(
    int? month,
    int? year, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [month, year],
        includeLower: include,
        upper: [month],
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthEqualToYearLessThan(
    int? month,
    int? year, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [month],
        upper: [month, year],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterWhereClause> monthEqualToYearBetween(
    int? month,
    int? lowerYear,
    int? upperYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'month_year',
        lower: [month, lowerYear],
        includeLower: includeLower,
        upper: [month, upperYear],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarListeningHistoryMonthSummaryQueryFilter on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QFilterCondition> {
  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> artistsCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artistsCount',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> artistsCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artistsCount',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> artistsCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> artistsCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artistsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> artistsCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artistsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> artistsCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artistsCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopArtistsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopArtists',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopArtistsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopArtists',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopArtistsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopArtists',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopArtistsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopArtists',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopArtistsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopArtists',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopArtistsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopArtists',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopTracksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopTracks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopTracksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopTracks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopTracksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopTracks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopTracksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopTracks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopTracksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopTracks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> isarTopTracksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTopTracks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> listeningMinutesTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listeningMinutesTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> listeningMinutesTotalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listeningMinutesTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> listeningMinutesTotalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listeningMinutesTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> listeningMinutesTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listeningMinutesTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> monthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'month',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> monthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'month',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> monthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> monthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> monthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> monthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'month',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> mostListenedOnDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mostListenedOnDay',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> mostListenedOnDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mostListenedOnDay',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> mostListenedOnDayEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mostListenedOnDay',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> mostListenedOnDayGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mostListenedOnDay',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> mostListenedOnDayLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mostListenedOnDay',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> mostListenedOnDayBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mostListenedOnDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tracksCount',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tracksCount',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tracksCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tracksCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tracksCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tracksCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIncreasePercentageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tracksCountIncreasePercentage',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIncreasePercentageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tracksCountIncreasePercentage',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIncreasePercentageEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tracksCountIncreasePercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIncreasePercentageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tracksCountIncreasePercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIncreasePercentageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tracksCountIncreasePercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksCountIncreasePercentageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tracksCountIncreasePercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksRepetitionPercentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tracksRepetitionPercent',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksRepetitionPercentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tracksRepetitionPercent',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksRepetitionPercentEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tracksRepetitionPercent',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksRepetitionPercentGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tracksRepetitionPercent',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksRepetitionPercentLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tracksRepetitionPercent',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> tracksRepetitionPercentBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tracksRepetitionPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> yearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'year',
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> yearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'year',
      ));
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterFilterCondition> yearEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> yearGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> yearLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterFilterCondition> yearBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarListeningHistoryMonthSummaryQueryObject on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QFilterCondition> {
  QueryBuilder<IsarListeningHistoryMonthSummary,
          IsarListeningHistoryMonthSummary, QAfterFilterCondition>
      isarTopArtistsElement(
          FilterQuery<IsarMonthListeningHistoryArtistSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarTopArtists');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
          IsarListeningHistoryMonthSummary, QAfterFilterCondition>
      isarTopTracksElement(
          FilterQuery<IsarMonthListeningHistoryTrackSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarTopTracks');
    });
  }
}

extension IsarListeningHistoryMonthSummaryQueryLinks on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QFilterCondition> {}

extension IsarListeningHistoryMonthSummaryQuerySortBy on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QSortBy> {
  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByArtistsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistsCount', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByArtistsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistsCount', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByListeningMinutesTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeningMinutesTotal', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByListeningMinutesTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeningMinutesTotal', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByMostListenedOnDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mostListenedOnDay', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByMostListenedOnDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mostListenedOnDay', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByTracksCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCount', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByTracksCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCount', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByTracksCountIncreasePercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCountIncreasePercentage', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByTracksCountIncreasePercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCountIncreasePercentage', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByTracksRepetitionPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksRepetitionPercent', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> sortByTracksRepetitionPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksRepetitionPercent', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension IsarListeningHistoryMonthSummaryQuerySortThenBy on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QSortThenBy> {
  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByArtistsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistsCount', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByArtistsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistsCount', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByListeningMinutesTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeningMinutesTotal', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByListeningMinutesTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listeningMinutesTotal', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByMostListenedOnDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mostListenedOnDay', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByMostListenedOnDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mostListenedOnDay', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByTracksCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCount', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByTracksCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCount', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByTracksCountIncreasePercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCountIncreasePercentage', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByTracksCountIncreasePercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksCountIncreasePercentage', Sort.desc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByTracksRepetitionPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksRepetitionPercent', Sort.asc);
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QAfterSortBy> thenByTracksRepetitionPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tracksRepetitionPercent', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension IsarListeningHistoryMonthSummaryQueryWhereDistinct on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QDistinct> {
  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QDistinct> distinctByArtistsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artistsCount');
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QDistinct> distinctByListeningMinutesTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listeningMinutesTotal');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QDistinct> distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QDistinct> distinctByMostListenedOnDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mostListenedOnDay');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QDistinct> distinctByTracksCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tracksCount');
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QDistinct> distinctByTracksCountIncreasePercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tracksCountIncreasePercentage');
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary,
      QDistinct> distinctByTracksRepetitionPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tracksRepetitionPercent');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary,
      IsarListeningHistoryMonthSummary, QDistinct> distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension IsarListeningHistoryMonthSummaryQueryProperty on QueryBuilder<
    IsarListeningHistoryMonthSummary,
    IsarListeningHistoryMonthSummary,
    QQueryProperty> {
  QueryBuilder<IsarListeningHistoryMonthSummary, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, int?, QQueryOperations>
      artistsCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artistsCount');
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      List<IsarMonthListeningHistoryArtistSummary>,
      QQueryOperations> isarTopArtistsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarTopArtists');
    });
  }

  QueryBuilder<
      IsarListeningHistoryMonthSummary,
      List<IsarMonthListeningHistoryTrackSummary>,
      QQueryOperations> isarTopTracksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarTopTracks');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, int, QQueryOperations>
      listeningMinutesTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listeningMinutesTotal');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, int?, QQueryOperations>
      monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, DateTime?, QQueryOperations>
      mostListenedOnDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mostListenedOnDay');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, int?, QQueryOperations>
      tracksCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tracksCount');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, double?, QQueryOperations>
      tracksCountIncreasePercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tracksCountIncreasePercentage');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, int?, QQueryOperations>
      tracksRepetitionPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tracksRepetitionPercent');
    });
  }

  QueryBuilder<IsarListeningHistoryMonthSummary, int?, QQueryOperations>
      yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarMonthListeningHistoryArtistSummarySchema = Schema(
  name: r'IsarMonthListeningHistoryArtistSummary',
  id: 2444016072203521194,
  properties: {
    r'artistId': PropertySchema(
      id: 0,
      name: r'artistId',
      type: IsarType.string,
    ),
    r'listenedToTracksCount': PropertySchema(
      id: 1,
      name: r'listenedToTracksCount',
      type: IsarType.long,
    )
  },
  estimateSize: _isarMonthListeningHistoryArtistSummaryEstimateSize,
  serialize: _isarMonthListeningHistoryArtistSummarySerialize,
  deserialize: _isarMonthListeningHistoryArtistSummaryDeserialize,
  deserializeProp: _isarMonthListeningHistoryArtistSummaryDeserializeProp,
);

int _isarMonthListeningHistoryArtistSummaryEstimateSize(
  IsarMonthListeningHistoryArtistSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.artistId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarMonthListeningHistoryArtistSummarySerialize(
  IsarMonthListeningHistoryArtistSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.artistId);
  writer.writeLong(offsets[1], object.listenedToTracksCount);
}

IsarMonthListeningHistoryArtistSummary
    _isarMonthListeningHistoryArtistSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMonthListeningHistoryArtistSummary(
    artistId: reader.readStringOrNull(offsets[0]),
    listenedToTracksCount: reader.readLongOrNull(offsets[1]),
  );
  return object;
}

P _isarMonthListeningHistoryArtistSummaryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarMonthListeningHistoryArtistSummaryQueryFilter on QueryBuilder<
    IsarMonthListeningHistoryArtistSummary,
    IsarMonthListeningHistoryArtistSummary,
    QFilterCondition> {
  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artistId',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artistId',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMonthListeningHistoryArtistSummary,
          IsarMonthListeningHistoryArtistSummary, QAfterFilterCondition>
      artistIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artistId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMonthListeningHistoryArtistSummary,
          IsarMonthListeningHistoryArtistSummary, QAfterFilterCondition>
      artistIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artistId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistId',
        value: '',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> artistIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artistId',
        value: '',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> listenedToTracksCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'listenedToTracksCount',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> listenedToTracksCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'listenedToTracksCount',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> listenedToTracksCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listenedToTracksCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> listenedToTracksCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listenedToTracksCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> listenedToTracksCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listenedToTracksCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryArtistSummary,
      IsarMonthListeningHistoryArtistSummary,
      QAfterFilterCondition> listenedToTracksCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listenedToTracksCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarMonthListeningHistoryArtistSummaryQueryObject on QueryBuilder<
    IsarMonthListeningHistoryArtistSummary,
    IsarMonthListeningHistoryArtistSummary,
    QFilterCondition> {}
