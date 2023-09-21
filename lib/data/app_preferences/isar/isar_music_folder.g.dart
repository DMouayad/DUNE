// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_music_folder.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarMusicFolderSchema = Schema(
  name: r'IsarMusicFolder',
  id: -8023413789342582895,
  properties: {
    r'addedOn': PropertySchema(
      id: 0,
      name: r'addedOn',
      type: IsarType.dateTime,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'path': PropertySchema(
      id: 2,
      name: r'path',
      type: IsarType.string,
    ),
    r'stringify': PropertySchema(
      id: 3,
      name: r'stringify',
      type: IsarType.bool,
    ),
    r'subFoldersList': PropertySchema(
      id: 4,
      name: r'subFoldersList',
      type: IsarType.stringList,
    )
  },
  estimateSize: _isarMusicFolderEstimateSize,
  serialize: _isarMusicFolderSerialize,
  deserialize: _isarMusicFolderDeserialize,
  deserializeProp: _isarMusicFolderDeserializeProp,
);

int _isarMusicFolderEstimateSize(
  IsarMusicFolder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.path.length * 3;
  bytesCount += 3 + object.subFoldersList.length * 3;
  {
    for (var i = 0; i < object.subFoldersList.length; i++) {
      final value = object.subFoldersList[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _isarMusicFolderSerialize(
  IsarMusicFolder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.addedOn);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.path);
  writer.writeBool(offsets[3], object.stringify);
  writer.writeStringList(offsets[4], object.subFoldersList);
}

IsarMusicFolder _isarMusicFolderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMusicFolder(
    path: reader.readStringOrNull(offsets[2]) ?? '',
    subFoldersList: reader.readStringList(offsets[4]) ?? const [],
  );
  return object;
}

P _isarMusicFolderDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarMusicFolderQueryFilter
    on QueryBuilder<IsarMusicFolder, IsarMusicFolder, QFilterCondition> {
  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      addedOnEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      addedOnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      addedOnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      addedOnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      hashCodeGreaterThan(
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

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      hashCodeLessThan(
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

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      hashCodeBetween(
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

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      stringifyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stringify',
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      stringifyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stringify',
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      stringifyEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stringify',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subFoldersList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subFoldersList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subFoldersList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subFoldersList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subFoldersList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subFoldersList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subFoldersList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subFoldersList',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subFoldersList',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subFoldersList',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subFoldersList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subFoldersList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subFoldersList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subFoldersList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subFoldersList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarMusicFolder, IsarMusicFolder, QAfterFilterCondition>
      subFoldersListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subFoldersList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension IsarMusicFolderQueryObject
    on QueryBuilder<IsarMusicFolder, IsarMusicFolder, QFilterCondition> {}
