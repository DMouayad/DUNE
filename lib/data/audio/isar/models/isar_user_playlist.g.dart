// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_user_playlist.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarUserPlaylistCollection on Isar {
  IsarCollection<IsarUserPlaylist> get isarUserPlaylists => this.collection();
}

const IsarUserPlaylistSchema = CollectionSchema(
  name: r'IsarUserPlaylist',
  id: -7916998531257489022,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdAtDate': PropertySchema(
      id: 1,
      name: r'createdAtDate',
      type: IsarType.dateTime,
    ),
    r'isarLength': PropertySchema(
      id: 2,
      name: r'isarLength',
      type: IsarType.object,
      target: r'IsarDuration',
    ),
    r'playlistId': PropertySchema(
      id: 3,
      name: r'playlistId',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _isarUserPlaylistEstimateSize,
  serialize: _isarUserPlaylistSerialize,
  deserialize: _isarUserPlaylistDeserialize,
  deserializeProp: _isarUserPlaylistDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'IsarDuration': IsarDurationSchema},
  getId: _isarUserPlaylistGetId,
  getLinks: _isarUserPlaylistGetLinks,
  attach: _isarUserPlaylistAttach,
  version: '3.1.0+1',
);

int _isarUserPlaylistEstimateSize(
  IsarUserPlaylist object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      IsarDurationSchema.estimateSize(
          object.isarLength, allOffsets[IsarDuration]!, allOffsets);
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _isarUserPlaylistSerialize(
  IsarUserPlaylist object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.createdAtDate);
  writer.writeObject<IsarDuration>(
    offsets[2],
    allOffsets,
    IsarDurationSchema.serialize,
    object.isarLength,
  );
  writer.writeLong(offsets[3], object.playlistId);
  writer.writeString(offsets[4], object.title);
}

IsarUserPlaylist _isarUserPlaylistDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarUserPlaylist(
    createdAtDate: reader.readDateTimeOrNull(offsets[1]),
    isarLength: reader.readObjectOrNull<IsarDuration>(
          offsets[2],
          IsarDurationSchema.deserialize,
          allOffsets,
        ) ??
        const IsarDuration(),
    playlistId: reader.readLongOrNull(offsets[3]),
    title: reader.readStringOrNull(offsets[4]) ?? '',
  );
  object.id = id;
  return object;
}

P _isarUserPlaylistDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<IsarDuration>(
            offset,
            IsarDurationSchema.deserialize,
            allOffsets,
          ) ??
          const IsarDuration()) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarUserPlaylistGetId(IsarUserPlaylist object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarUserPlaylistGetLinks(IsarUserPlaylist object) {
  return [];
}

void _isarUserPlaylistAttach(
    IsarCollection<dynamic> col, Id id, IsarUserPlaylist object) {
  object.id = id;
}

extension IsarUserPlaylistQueryWhereSort
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QWhere> {
  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarUserPlaylistQueryWhere
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QWhereClause> {
  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterWhereClause>
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterWhereClause> idBetween(
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

extension IsarUserPlaylistQueryFilter
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QFilterCondition> {
  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtDate',
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtDate',
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      createdAtDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      playlistIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playlistId',
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      playlistIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playlistId',
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      playlistIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      playlistIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      playlistIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      playlistIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playlistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleEqualTo(
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleGreaterThan(
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleLessThan(
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleBetween(
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleStartsWith(
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleEndsWith(
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

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension IsarUserPlaylistQueryObject
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QFilterCondition> {
  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterFilterCondition>
      isarLength(FilterQuery<IsarDuration> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarLength');
    });
  }
}

extension IsarUserPlaylistQueryLinks
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QFilterCondition> {}

extension IsarUserPlaylistQuerySortBy
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QSortBy> {
  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      sortByCreatedAtDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtDate', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      sortByCreatedAtDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtDate', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      sortByPlaylistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      sortByPlaylistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarUserPlaylistQuerySortThenBy
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QSortThenBy> {
  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByCreatedAtDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtDate', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByCreatedAtDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtDate', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByPlaylistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByPlaylistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playlistId', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarUserPlaylistQueryWhereDistinct
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QDistinct> {
  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QDistinct>
      distinctByCreatedAtDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtDate');
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QDistinct>
      distinctByPlaylistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playlistId');
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension IsarUserPlaylistQueryProperty
    on QueryBuilder<IsarUserPlaylist, IsarUserPlaylist, QQueryProperty> {
  QueryBuilder<IsarUserPlaylist, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarUserPlaylist, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<IsarUserPlaylist, DateTime?, QQueryOperations>
      createdAtDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtDate');
    });
  }

  QueryBuilder<IsarUserPlaylist, IsarDuration, QQueryOperations>
      isarLengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarLength');
    });
  }

  QueryBuilder<IsarUserPlaylist, int?, QQueryOperations> playlistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playlistId');
    });
  }

  QueryBuilder<IsarUserPlaylist, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
