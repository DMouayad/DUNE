// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_track_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarTrackRecordCollection on Isar {
  IsarCollection<IsarTrackRecord> get isarTrackRecords => this.collection();
}

const IsarTrackRecordSchema = CollectionSchema(
  name: r'IsarTrackRecord',
  id: -842626602016662650,
  properties: {
    r'listeningHistory': PropertySchema(
      id: 0,
      name: r'listeningHistory',
      type: IsarType.objectList,
      target: r'IsarListeningRecord',
    ),
    r'trackId': PropertySchema(
      id: 1,
      name: r'trackId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarTrackRecordEstimateSize,
  serialize: _isarTrackRecordSerialize,
  deserialize: _isarTrackRecordDeserialize,
  deserializeProp: _isarTrackRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'trackId': IndexSchema(
      id: -8614467705999066844,
      name: r'trackId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'trackId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'IsarListeningRecord': IsarListeningRecordSchema},
  getId: _isarTrackRecordGetId,
  getLinks: _isarTrackRecordGetLinks,
  attach: _isarTrackRecordAttach,
  version: '3.1.0+1',
);

int _isarTrackRecordEstimateSize(
  IsarTrackRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.listeningHistory.length * 3;
  {
    final offsets = allOffsets[IsarListeningRecord]!;
    for (var i = 0; i < object.listeningHistory.length; i++) {
      final value = object.listeningHistory[i];
      bytesCount +=
          IsarListeningRecordSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.trackId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarTrackRecordSerialize(
  IsarTrackRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<IsarListeningRecord>(
    offsets[0],
    allOffsets,
    IsarListeningRecordSchema.serialize,
    object.listeningHistory,
  );
  writer.writeString(offsets[1], object.trackId);
}

IsarTrackRecord _isarTrackRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarTrackRecord(
    id: id,
    listeningHistory: reader.readObjectList<IsarListeningRecord>(
          offsets[0],
          IsarListeningRecordSchema.deserialize,
          allOffsets,
          IsarListeningRecord(),
        ) ??
        const [],
    trackId: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _isarTrackRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<IsarListeningRecord>(
            offset,
            IsarListeningRecordSchema.deserialize,
            allOffsets,
            IsarListeningRecord(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarTrackRecordGetId(IsarTrackRecord object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarTrackRecordGetLinks(IsarTrackRecord object) {
  return [];
}

void _isarTrackRecordAttach(
    IsarCollection<dynamic> col, Id id, IsarTrackRecord object) {
  object.id = id;
}

extension IsarTrackRecordByIndex on IsarCollection<IsarTrackRecord> {
  Future<IsarTrackRecord?> getByTrackId(String? trackId) {
    return getByIndex(r'trackId', [trackId]);
  }

  IsarTrackRecord? getByTrackIdSync(String? trackId) {
    return getByIndexSync(r'trackId', [trackId]);
  }

  Future<bool> deleteByTrackId(String? trackId) {
    return deleteByIndex(r'trackId', [trackId]);
  }

  bool deleteByTrackIdSync(String? trackId) {
    return deleteByIndexSync(r'trackId', [trackId]);
  }

  Future<List<IsarTrackRecord?>> getAllByTrackId(List<String?> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'trackId', values);
  }

  List<IsarTrackRecord?> getAllByTrackIdSync(List<String?> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'trackId', values);
  }

  Future<int> deleteAllByTrackId(List<String?> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'trackId', values);
  }

  int deleteAllByTrackIdSync(List<String?> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'trackId', values);
  }

  Future<Id> putByTrackId(IsarTrackRecord object) {
    return putByIndex(r'trackId', object);
  }

  Id putByTrackIdSync(IsarTrackRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'trackId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTrackId(List<IsarTrackRecord> objects) {
    return putAllByIndex(r'trackId', objects);
  }

  List<Id> putAllByTrackIdSync(List<IsarTrackRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'trackId', objects, saveLinks: saveLinks);
  }
}

extension IsarTrackRecordQueryWhereSort
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QWhere> {
  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarTrackRecordQueryWhere
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QWhereClause> {
  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause> idBetween(
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

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause>
      trackIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'trackId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause>
      trackIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'trackId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause>
      trackIdEqualTo(String? trackId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'trackId',
        value: [trackId],
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterWhereClause>
      trackIdNotEqualTo(String? trackId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [],
              upper: [trackId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [trackId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [trackId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [],
              upper: [trackId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarTrackRecordQueryFilter
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QFilterCondition> {
  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      listeningHistoryLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeningHistory',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      listeningHistoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeningHistory',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      listeningHistoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeningHistory',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      listeningHistoryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeningHistory',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      listeningHistoryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeningHistory',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      listeningHistoryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listeningHistory',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackId',
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackId',
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      trackIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackId',
        value: '',
      ));
    });
  }
}

extension IsarTrackRecordQueryObject
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QFilterCondition> {
  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterFilterCondition>
      listeningHistoryElement(FilterQuery<IsarListeningRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'listeningHistory');
    });
  }
}

extension IsarTrackRecordQueryLinks
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QFilterCondition> {}

extension IsarTrackRecordQuerySortBy
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QSortBy> {
  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterSortBy> sortByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterSortBy>
      sortByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension IsarTrackRecordQuerySortThenBy
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QSortThenBy> {
  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterSortBy> thenByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QAfterSortBy>
      thenByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension IsarTrackRecordQueryWhereDistinct
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QDistinct> {
  QueryBuilder<IsarTrackRecord, IsarTrackRecord, QDistinct> distinctByTrackId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackId', caseSensitive: caseSensitive);
    });
  }
}

extension IsarTrackRecordQueryProperty
    on QueryBuilder<IsarTrackRecord, IsarTrackRecord, QQueryProperty> {
  QueryBuilder<IsarTrackRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarTrackRecord, List<IsarListeningRecord>, QQueryOperations>
      listeningHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listeningHistory');
    });
  }

  QueryBuilder<IsarTrackRecord, String?, QQueryOperations> trackIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarListeningRecordSchema = Schema(
  name: r'IsarListeningRecord',
  id: -1310174619664365089,
  properties: {
    r'completedListensCount': PropertySchema(
      id: 0,
      name: r'completedListensCount',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'uncompletedListensTotalDurationInSeconds': PropertySchema(
      id: 2,
      name: r'uncompletedListensTotalDurationInSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _isarListeningRecordEstimateSize,
  serialize: _isarListeningRecordSerialize,
  deserialize: _isarListeningRecordDeserialize,
  deserializeProp: _isarListeningRecordDeserializeProp,
);

int _isarListeningRecordEstimateSize(
  IsarListeningRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarListeningRecordSerialize(
  IsarListeningRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.completedListensCount);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeLong(offsets[2], object.uncompletedListensTotalDurationInSeconds);
}

IsarListeningRecord _isarListeningRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarListeningRecord(
    completedListensCount: reader.readLongOrNull(offsets[0]),
    date: reader.readDateTimeOrNull(offsets[1]),
  );
  return object;
}

P _isarListeningRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarListeningRecordQueryFilter on QueryBuilder<IsarListeningRecord,
    IsarListeningRecord, QFilterCondition> {
  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      completedListensCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedListensCount',
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      completedListensCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedListensCount',
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      completedListensCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedListensCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      completedListensCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedListensCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      completedListensCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedListensCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      completedListensCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedListensCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      dateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      uncompletedListensTotalDurationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uncompletedListensTotalDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      uncompletedListensTotalDurationInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uncompletedListensTotalDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      uncompletedListensTotalDurationInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uncompletedListensTotalDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningRecord, IsarListeningRecord, QAfterFilterCondition>
      uncompletedListensTotalDurationInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uncompletedListensTotalDurationInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarListeningRecordQueryObject on QueryBuilder<IsarListeningRecord,
    IsarListeningRecord, QFilterCondition> {}
