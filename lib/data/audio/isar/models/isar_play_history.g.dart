// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_play_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarListeningHistoryCollection on Isar {
  IsarCollection<IsarListeningHistory> get isarListeningHistorys =>
      this.collection();
}

const IsarListeningHistorySchema = CollectionSchema(
  name: r'IsarListeningHistory',
  id: 8684289237353587374,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'isarPlaylistsIds': PropertySchema(
      id: 1,
      name: r'isarPlaylistsIds',
      type: IsarType.longList,
    ),
    r'isarTrackRecordsIds': PropertySchema(
      id: 2,
      name: r'isarTrackRecordsIds',
      type: IsarType.longList,
    )
  },
  estimateSize: _isarListeningHistoryEstimateSize,
  serialize: _isarListeningHistorySerialize,
  deserialize: _isarListeningHistoryDeserialize,
  deserializeProp: _isarListeningHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarListeningHistoryGetId,
  getLinks: _isarListeningHistoryGetLinks,
  attach: _isarListeningHistoryAttach,
  version: '3.1.0+1',
);

int _isarListeningHistoryEstimateSize(
  IsarListeningHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.isarPlaylistsIds.length * 8;
  bytesCount += 3 + object.isarTrackRecordsIds.length * 8;
  return bytesCount;
}

void _isarListeningHistorySerialize(
  IsarListeningHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLongList(offsets[1], object.isarPlaylistsIds);
  writer.writeLongList(offsets[2], object.isarTrackRecordsIds);
}

IsarListeningHistory _isarListeningHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarListeningHistory(
    date: reader.readDateTime(offsets[0]),
    id: id,
    isarPlaylistsIds: reader.readLongList(offsets[1]) ?? const [],
    isarTrackRecordsIds: reader.readLongList(offsets[2]) ?? const [],
  );
  return object;
}

P _isarListeningHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLongList(offset) ?? const []) as P;
    case 2:
      return (reader.readLongList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarListeningHistoryGetId(IsarListeningHistory object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarListeningHistoryGetLinks(
    IsarListeningHistory object) {
  return [];
}

void _isarListeningHistoryAttach(
    IsarCollection<dynamic> col, Id id, IsarListeningHistory object) {
  object.id = id;
}

extension IsarListeningHistoryQueryWhereSort
    on QueryBuilder<IsarListeningHistory, IsarListeningHistory, QWhere> {
  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarListeningHistoryQueryWhere
    on QueryBuilder<IsarListeningHistory, IsarListeningHistory, QWhereClause> {
  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterWhereClause>
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

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterWhereClause>
      idBetween(
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
}

extension IsarListeningHistoryQueryFilter on QueryBuilder<IsarListeningHistory,
    IsarListeningHistory, QFilterCondition> {
  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
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

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> dateLessThan(
    DateTime value, {
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

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
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

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
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

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
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

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
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

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarPlaylistsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarPlaylistsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarPlaylistsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarPlaylistsIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarPlaylistsIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarPlaylistsIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarPlaylistsIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarPlaylistsIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarPlaylistsIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarPlaylistsIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarTrackRecordsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarTrackRecordsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarTrackRecordsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarTrackRecordsIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTrackRecordsIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTrackRecordsIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTrackRecordsIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTrackRecordsIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTrackRecordsIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory,
      QAfterFilterCondition> isarTrackRecordsIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarTrackRecordsIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension IsarListeningHistoryQueryObject on QueryBuilder<IsarListeningHistory,
    IsarListeningHistory, QFilterCondition> {}

extension IsarListeningHistoryQueryLinks on QueryBuilder<IsarListeningHistory,
    IsarListeningHistory, QFilterCondition> {}

extension IsarListeningHistoryQuerySortBy
    on QueryBuilder<IsarListeningHistory, IsarListeningHistory, QSortBy> {
  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }
}

extension IsarListeningHistoryQuerySortThenBy
    on QueryBuilder<IsarListeningHistory, IsarListeningHistory, QSortThenBy> {
  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension IsarListeningHistoryQueryWhereDistinct
    on QueryBuilder<IsarListeningHistory, IsarListeningHistory, QDistinct> {
  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QDistinct>
      distinctByIsarPlaylistsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isarPlaylistsIds');
    });
  }

  QueryBuilder<IsarListeningHistory, IsarListeningHistory, QDistinct>
      distinctByIsarTrackRecordsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isarTrackRecordsIds');
    });
  }
}

extension IsarListeningHistoryQueryProperty on QueryBuilder<
    IsarListeningHistory, IsarListeningHistory, QQueryProperty> {
  QueryBuilder<IsarListeningHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarListeningHistory, DateTime, QQueryOperations>
      dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<IsarListeningHistory, List<int>, QQueryOperations>
      isarPlaylistsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarPlaylistsIds');
    });
  }

  QueryBuilder<IsarListeningHistory, List<int>, QQueryOperations>
      isarTrackRecordsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarTrackRecordsIds');
    });
  }
}
