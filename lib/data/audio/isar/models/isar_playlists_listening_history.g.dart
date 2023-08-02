// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_playlists_listening_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarPlaylistsListeningHistoryCollection on Isar {
  IsarCollection<IsarPlaylistsListeningHistory>
      get isarPlaylistsListeningHistorys => this.collection();
}

const IsarPlaylistsListeningHistorySchema = CollectionSchema(
  name: r'IsarPlaylistsListeningHistory',
  id: -3114082971097050076,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'isarPlaylistsIds': PropertySchema(
      id: 2,
      name: r'isarPlaylistsIds',
      type: IsarType.longList,
    )
  },
  estimateSize: _isarPlaylistsListeningHistoryEstimateSize,
  serialize: _isarPlaylistsListeningHistorySerialize,
  deserialize: _isarPlaylistsListeningHistoryDeserialize,
  deserializeProp: _isarPlaylistsListeningHistoryDeserializeProp,
  idName: r'id',
  indexes: {
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
  getId: _isarPlaylistsListeningHistoryGetId,
  getLinks: _isarPlaylistsListeningHistoryGetLinks,
  attach: _isarPlaylistsListeningHistoryAttach,
  version: '3.1.0+1',
);

int _isarPlaylistsListeningHistoryEstimateSize(
  IsarPlaylistsListeningHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.isarPlaylistsIds.length * 8;
  return bytesCount;
}

void _isarPlaylistsListeningHistorySerialize(
  IsarPlaylistsListeningHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeLongList(offsets[2], object.isarPlaylistsIds);
}

IsarPlaylistsListeningHistory _isarPlaylistsListeningHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarPlaylistsListeningHistory(
    date: reader.readDateTime(offsets[0]),
    id: id,
    isarPlaylistsIds: reader.readLongList(offsets[2]) ?? const [],
  );
  return object;
}

P _isarPlaylistsListeningHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarPlaylistsListeningHistoryGetId(IsarPlaylistsListeningHistory object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarPlaylistsListeningHistoryGetLinks(
    IsarPlaylistsListeningHistory object) {
  return [];
}

void _isarPlaylistsListeningHistoryAttach(
    IsarCollection<dynamic> col, Id id, IsarPlaylistsListeningHistory object) {
  object.id = id;
}

extension IsarPlaylistsListeningHistoryQueryWhereSort on QueryBuilder<
    IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory, QWhere> {
  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension IsarPlaylistsListeningHistoryQueryWhere on QueryBuilder<
    IsarPlaylistsListeningHistory,
    IsarPlaylistsListeningHistory,
    QWhereClause> {
  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> dateNotEqualTo(DateTime date) {
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> dateGreaterThan(
    DateTime date, {
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> dateLessThan(
    DateTime date, {
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
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

extension IsarPlaylistsListeningHistoryQueryFilter on QueryBuilder<
    IsarPlaylistsListeningHistory,
    IsarPlaylistsListeningHistory,
    QFilterCondition> {
  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterFilterCondition> isarPlaylistsIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarPlaylistsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
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
}

extension IsarPlaylistsListeningHistoryQueryObject on QueryBuilder<
    IsarPlaylistsListeningHistory,
    IsarPlaylistsListeningHistory,
    QFilterCondition> {}

extension IsarPlaylistsListeningHistoryQueryLinks on QueryBuilder<
    IsarPlaylistsListeningHistory,
    IsarPlaylistsListeningHistory,
    QFilterCondition> {}

extension IsarPlaylistsListeningHistoryQuerySortBy on QueryBuilder<
    IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory, QSortBy> {
  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }
}

extension IsarPlaylistsListeningHistoryQuerySortThenBy on QueryBuilder<
    IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory, QSortThenBy> {
  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension IsarPlaylistsListeningHistoryQueryWhereDistinct on QueryBuilder<
    IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory, QDistinct> {
  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, IsarPlaylistsListeningHistory,
      QDistinct> distinctByIsarPlaylistsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isarPlaylistsIds');
    });
  }
}

extension IsarPlaylistsListeningHistoryQueryProperty on QueryBuilder<
    IsarPlaylistsListeningHistory,
    IsarPlaylistsListeningHistory,
    QQueryProperty> {
  QueryBuilder<IsarPlaylistsListeningHistory, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, DateTime, QQueryOperations>
      dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<IsarPlaylistsListeningHistory, List<int>, QQueryOperations>
      isarPlaylistsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarPlaylistsIds');
    });
  }
}
