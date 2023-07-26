// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_category_playlists.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarCategoryPlaylistsCollection on Isar {
  IsarCollection<IsarCategoryPlaylists> get isarCategoryPlaylists =>
      this.collection();
}

const IsarCategoryPlaylistsSchema = CollectionSchema(
  name: r'IsarCategoryPlaylists',
  id: -4787623676924467667,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.string,
    ),
    r'playlistsIds': PropertySchema(
      id: 1,
      name: r'playlistsIds',
      type: IsarType.stringList,
    )
  },
  estimateSize: _isarCategoryPlaylistsEstimateSize,
  serialize: _isarCategoryPlaylistsSerialize,
  deserialize: _isarCategoryPlaylistsDeserialize,
  deserializeProp: _isarCategoryPlaylistsDeserializeProp,
  idName: r'id',
  indexes: {
    r'categoryId': IndexSchema(
      id: -8798048739239305339,
      name: r'categoryId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'categoryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarCategoryPlaylistsGetId,
  getLinks: _isarCategoryPlaylistsGetLinks,
  attach: _isarCategoryPlaylistsAttach,
  version: '3.1.0+1',
);

int _isarCategoryPlaylistsEstimateSize(
  IsarCategoryPlaylists object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.categoryId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.playlistsIds.length * 3;
  {
    for (var i = 0; i < object.playlistsIds.length; i++) {
      final value = object.playlistsIds[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _isarCategoryPlaylistsSerialize(
  IsarCategoryPlaylists object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoryId);
  writer.writeStringList(offsets[1], object.playlistsIds);
}

IsarCategoryPlaylists _isarCategoryPlaylistsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarCategoryPlaylists(
    categoryId: reader.readStringOrNull(offsets[0]),
    id: id,
    playlistsIds: reader.readStringList(offsets[1]) ?? const [],
  );
  return object;
}

P _isarCategoryPlaylistsDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarCategoryPlaylistsGetId(IsarCategoryPlaylists object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarCategoryPlaylistsGetLinks(
    IsarCategoryPlaylists object) {
  return [];
}

void _isarCategoryPlaylistsAttach(
    IsarCollection<dynamic> col, Id id, IsarCategoryPlaylists object) {}

extension IsarCategoryPlaylistsQueryWhereSort
    on QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QWhere> {
  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarCategoryPlaylistsQueryWhere on QueryBuilder<IsarCategoryPlaylists,
    IsarCategoryPlaylists, QWhereClause> {
  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
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

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
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

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
      categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'categoryId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
      categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'categoryId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
      categoryIdEqualTo(String? categoryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'categoryId',
        value: [categoryId],
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterWhereClause>
      categoryIdNotEqualTo(String? categoryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [],
              upper: [categoryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [categoryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [categoryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [],
              upper: [categoryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarCategoryPlaylistsQueryFilter on QueryBuilder<
    IsarCategoryPlaylists, IsarCategoryPlaylists, QFilterCondition> {
  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
          QAfterFilterCondition>
      categoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
          QAfterFilterCondition>
      categoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> categoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
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

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
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

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
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

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playlistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playlistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playlistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playlistsIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playlistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playlistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
          QAfterFilterCondition>
      playlistsIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playlistsIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
          QAfterFilterCondition>
      playlistsIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playlistsIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playlistsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playlistsIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playlistsIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playlistsIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playlistsIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playlistsIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playlistsIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists,
      QAfterFilterCondition> playlistsIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playlistsIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension IsarCategoryPlaylistsQueryObject on QueryBuilder<
    IsarCategoryPlaylists, IsarCategoryPlaylists, QFilterCondition> {}

extension IsarCategoryPlaylistsQueryLinks on QueryBuilder<IsarCategoryPlaylists,
    IsarCategoryPlaylists, QFilterCondition> {}

extension IsarCategoryPlaylistsQuerySortBy
    on QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QSortBy> {
  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterSortBy>
      sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }
}

extension IsarCategoryPlaylistsQuerySortThenBy
    on QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QSortThenBy> {
  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterSortBy>
      thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension IsarCategoryPlaylistsQueryWhereDistinct
    on QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QDistinct> {
  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QDistinct>
      distinctByCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarCategoryPlaylists, IsarCategoryPlaylists, QDistinct>
      distinctByPlaylistsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playlistsIds');
    });
  }
}

extension IsarCategoryPlaylistsQueryProperty on QueryBuilder<
    IsarCategoryPlaylists, IsarCategoryPlaylists, QQueryProperty> {
  QueryBuilder<IsarCategoryPlaylists, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarCategoryPlaylists, String?, QQueryOperations>
      categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<IsarCategoryPlaylists, List<String>, QQueryOperations>
      playlistsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playlistsIds');
    });
  }
}
