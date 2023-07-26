// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_track_listening_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarTrackListeningHistoryCollection on Isar {
  IsarCollection<IsarTrackListeningHistory> get isarTrackListeningHistorys =>
      this.collection();
}

const IsarTrackListeningHistorySchema = CollectionSchema(
  name: r'IsarTrackListeningHistory',
  id: 5299617480085168264,
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
    r'totalListeningDurationInSeconds': PropertySchema(
      id: 2,
      name: r'totalListeningDurationInSeconds',
      type: IsarType.long,
    ),
    r'trackId': PropertySchema(
      id: 3,
      name: r'trackId',
      type: IsarType.string,
    ),
    r'uncompletedListensTotalDurationInSeconds': PropertySchema(
      id: 4,
      name: r'uncompletedListensTotalDurationInSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _isarTrackListeningHistoryEstimateSize,
  serialize: _isarTrackListeningHistorySerialize,
  deserialize: _isarTrackListeningHistoryDeserialize,
  deserializeProp: _isarTrackListeningHistoryDeserializeProp,
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
    ),
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarTrackListeningHistoryGetId,
  getLinks: _isarTrackListeningHistoryGetLinks,
  attach: _isarTrackListeningHistoryAttach,
  version: '3.1.0+1',
);

int _isarTrackListeningHistoryEstimateSize(
  IsarTrackListeningHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.trackId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarTrackListeningHistorySerialize(
  IsarTrackListeningHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.completedListensCount);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeLong(offsets[2], object.totalListeningDurationInSeconds);
  writer.writeString(offsets[3], object.trackId);
  writer.writeLong(offsets[4], object.uncompletedListensTotalDurationInSeconds);
}

IsarTrackListeningHistory _isarTrackListeningHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarTrackListeningHistory(
    completedListensCount: reader.readLongOrNull(offsets[0]),
    date: reader.readDateTimeOrNull(offsets[1]),
    id: id,
    trackId: reader.readStringOrNull(offsets[3]),
    uncompletedListensTotalDurationInSeconds:
        reader.readLongOrNull(offsets[4]) ?? 0,
  );
  return object;
}

P _isarTrackListeningHistoryDeserializeProp<P>(
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
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarTrackListeningHistoryGetId(IsarTrackListeningHistory object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarTrackListeningHistoryGetLinks(
    IsarTrackListeningHistory object) {
  return [];
}

void _isarTrackListeningHistoryAttach(
    IsarCollection<dynamic> col, Id id, IsarTrackListeningHistory object) {
  object.id = id;
}

extension IsarTrackListeningHistoryByIndex
    on IsarCollection<IsarTrackListeningHistory> {
  Future<IsarTrackListeningHistory?> getByTrackId(String? trackId) {
    return getByIndex(r'trackId', [trackId]);
  }

  IsarTrackListeningHistory? getByTrackIdSync(String? trackId) {
    return getByIndexSync(r'trackId', [trackId]);
  }

  Future<bool> deleteByTrackId(String? trackId) {
    return deleteByIndex(r'trackId', [trackId]);
  }

  bool deleteByTrackIdSync(String? trackId) {
    return deleteByIndexSync(r'trackId', [trackId]);
  }

  Future<List<IsarTrackListeningHistory?>> getAllByTrackId(
      List<String?> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'trackId', values);
  }

  List<IsarTrackListeningHistory?> getAllByTrackIdSync(
      List<String?> trackIdValues) {
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

  Future<Id> putByTrackId(IsarTrackListeningHistory object) {
    return putByIndex(r'trackId', object);
  }

  Id putByTrackIdSync(IsarTrackListeningHistory object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'trackId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTrackId(List<IsarTrackListeningHistory> objects) {
    return putAllByIndex(r'trackId', objects);
  }

  List<Id> putAllByTrackIdSync(List<IsarTrackListeningHistory> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'trackId', objects, saveLinks: saveLinks);
  }
}

extension IsarTrackListeningHistoryQueryWhereSort on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QWhere> {
  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension IsarTrackListeningHistoryQueryWhere on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QWhereClause> {
  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> trackIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'trackId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> trackIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'trackId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> trackIdEqualTo(String? trackId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'trackId',
        value: [trackId],
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> trackIdNotEqualTo(String? trackId) {
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> dateEqualTo(DateTime? date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> dateNotEqualTo(DateTime? date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> dateGreaterThan(
    DateTime? date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> dateLessThan(
    DateTime? date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterWhereClause> dateBetween(
    DateTime? lowerDate,
    DateTime? upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarTrackListeningHistoryQueryFilter on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QFilterCondition> {
  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> completedListensCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedListensCount',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> completedListensCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedListensCount',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> completedListensCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedListensCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> completedListensCountGreaterThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> completedListensCountLessThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> completedListensCountBetween(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> dateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> dateBetween(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> totalListeningDurationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalListeningDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> totalListeningDurationInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalListeningDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> totalListeningDurationInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalListeningDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> totalListeningDurationInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalListeningDurationInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackId',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackId',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdEqualTo(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdGreaterThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdLessThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdBetween(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdStartsWith(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdEndsWith(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
          QAfterFilterCondition>
      trackIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
          QAfterFilterCondition>
      trackIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> trackIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
          QAfterFilterCondition>
      uncompletedListensTotalDurationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uncompletedListensTotalDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
          QAfterFilterCondition>
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> uncompletedListensTotalDurationInSecondsLessThan(
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

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterFilterCondition> uncompletedListensTotalDurationInSecondsBetween(
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

extension IsarTrackListeningHistoryQueryObject on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QFilterCondition> {}

extension IsarTrackListeningHistoryQueryLinks on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QFilterCondition> {}

extension IsarTrackListeningHistoryQuerySortBy on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QSortBy> {
  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByCompletedListensCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedListensCount', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByCompletedListensCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedListensCount', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByTotalListeningDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalListeningDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByTotalListeningDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalListeningDurationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByUncompletedListensTotalDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'uncompletedListensTotalDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> sortByUncompletedListensTotalDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'uncompletedListensTotalDurationInSeconds', Sort.desc);
    });
  }
}

extension IsarTrackListeningHistoryQuerySortThenBy on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QSortThenBy> {
  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByCompletedListensCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedListensCount', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByCompletedListensCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedListensCount', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByTotalListeningDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalListeningDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByTotalListeningDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalListeningDurationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByUncompletedListensTotalDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'uncompletedListensTotalDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory,
      QAfterSortBy> thenByUncompletedListensTotalDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'uncompletedListensTotalDurationInSeconds', Sort.desc);
    });
  }
}

extension IsarTrackListeningHistoryQueryWhereDistinct on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QDistinct> {
  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory, QDistinct>
      distinctByCompletedListensCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedListensCount');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory, QDistinct>
      distinctByTotalListeningDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalListeningDurationInSeconds');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory, QDistinct>
      distinctByTrackId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarTrackListeningHistory, IsarTrackListeningHistory, QDistinct>
      distinctByUncompletedListensTotalDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uncompletedListensTotalDurationInSeconds');
    });
  }
}

extension IsarTrackListeningHistoryQueryProperty on QueryBuilder<
    IsarTrackListeningHistory, IsarTrackListeningHistory, QQueryProperty> {
  QueryBuilder<IsarTrackListeningHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, int?, QQueryOperations>
      completedListensCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedListensCount');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, DateTime?, QQueryOperations>
      dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, int, QQueryOperations>
      totalListeningDurationInSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalListeningDurationInSeconds');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, String?, QQueryOperations>
      trackIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackId');
    });
  }

  QueryBuilder<IsarTrackListeningHistory, int, QQueryOperations>
      uncompletedListensTotalDurationInSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uncompletedListensTotalDurationInSeconds');
    });
  }
}
