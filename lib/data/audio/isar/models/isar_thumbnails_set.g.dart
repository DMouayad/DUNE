// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_thumbnails_set.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarThumbnailsSetSchema = Schema(
  name: r'IsarThumbnailsSet',
  id: -8661044366606144861,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'stringify': PropertySchema(
      id: 1,
      name: r'stringify',
      type: IsarType.bool,
    ),
    r'thumbnails': PropertySchema(
      id: 2,
      name: r'thumbnails',
      type: IsarType.objectList,
      target: r'IsarThumbnail',
    ),
    r'thumbnailsList': PropertySchema(
      id: 3,
      name: r'thumbnailsList',
      type: IsarType.objectList,
      target: r'IsarThumbnail',
    )
  },
  estimateSize: _isarThumbnailsSetEstimateSize,
  serialize: _isarThumbnailsSetSerialize,
  deserialize: _isarThumbnailsSetDeserialize,
  deserializeProp: _isarThumbnailsSetDeserializeProp,
);

int _isarThumbnailsSetEstimateSize(
  IsarThumbnailsSet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.thumbnails.length * 3;
  {
    final offsets = allOffsets[IsarThumbnail]!;
    for (var i = 0; i < object.thumbnails.length; i++) {
      final value = object.thumbnails[i];
      bytesCount +=
          IsarThumbnailSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.thumbnailsList.length * 3;
  {
    final offsets = allOffsets[IsarThumbnail]!;
    for (var i = 0; i < object.thumbnailsList.length; i++) {
      final value = object.thumbnailsList[i];
      bytesCount +=
          IsarThumbnailSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _isarThumbnailsSetSerialize(
  IsarThumbnailsSet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeBool(offsets[1], object.stringify);
  writer.writeObjectList<IsarThumbnail>(
    offsets[2],
    allOffsets,
    IsarThumbnailSchema.serialize,
    object.thumbnails,
  );
  writer.writeObjectList<IsarThumbnail>(
    offsets[3],
    allOffsets,
    IsarThumbnailSchema.serialize,
    object.thumbnailsList,
  );
}

IsarThumbnailsSet _isarThumbnailsSetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarThumbnailsSet(
    thumbnailsList: reader.readObjectList<IsarThumbnail>(
          offsets[3],
          IsarThumbnailSchema.deserialize,
          allOffsets,
          IsarThumbnail(),
        ) ??
        const [],
  );
  return object;
}

P _isarThumbnailsSetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<IsarThumbnail>(
            offset,
            IsarThumbnailSchema.deserialize,
            allOffsets,
            IsarThumbnail(),
          ) ??
          []) as P;
    case 3:
      return (reader.readObjectList<IsarThumbnail>(
            offset,
            IsarThumbnailSchema.deserialize,
            allOffsets,
            IsarThumbnail(),
          ) ??
          const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarThumbnailsSetQueryFilter
    on QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QFilterCondition> {
  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
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

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
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

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
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

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      stringifyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stringify',
      ));
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      stringifyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stringify',
      ));
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      stringifyEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stringify',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension IsarThumbnailsSetQueryObject
    on QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QFilterCondition> {
  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsElement(FilterQuery<IsarThumbnail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnails');
    });
  }

  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsListElement(FilterQuery<IsarThumbnail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnailsList');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarThumbnailSchema = Schema(
  name: r'IsarThumbnail',
  id: -5954095740166376557,
  properties: {
    r'height': PropertySchema(
      id: 0,
      name: r'height',
      type: IsarType.double,
    ),
    r'quality': PropertySchema(
      id: 1,
      name: r'quality',
      type: IsarType.byte,
      enumMap: _IsarThumbnailqualityEnumValueMap,
    ),
    r'url': PropertySchema(
      id: 2,
      name: r'url',
      type: IsarType.string,
    ),
    r'width': PropertySchema(
      id: 3,
      name: r'width',
      type: IsarType.double,
    )
  },
  estimateSize: _isarThumbnailEstimateSize,
  serialize: _isarThumbnailSerialize,
  deserialize: _isarThumbnailDeserialize,
  deserializeProp: _isarThumbnailDeserializeProp,
);

int _isarThumbnailEstimateSize(
  IsarThumbnail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _isarThumbnailSerialize(
  IsarThumbnail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeByte(offsets[1], object.quality.index);
  writer.writeString(offsets[2], object.url);
  writer.writeDouble(offsets[3], object.width);
}

IsarThumbnail _isarThumbnailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarThumbnail(
    height: reader.readDoubleOrNull(offsets[0]),
    quality:
        _IsarThumbnailqualityValueEnumMap[reader.readByteOrNull(offsets[1])] ??
            ThumbnailQuality.standard,
    url: reader.readStringOrNull(offsets[2]) ?? '',
    width: reader.readDoubleOrNull(offsets[3]),
  );
  return object;
}

P _isarThumbnailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (_IsarThumbnailqualityValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ThumbnailQuality.standard) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarThumbnailqualityEnumValueMap = {
  'standard': 0,
  'low': 1,
  'medium': 2,
  'high': 3,
  'max': 4,
};
const _IsarThumbnailqualityValueEnumMap = {
  0: ThumbnailQuality.standard,
  1: ThumbnailQuality.low,
  2: ThumbnailQuality.medium,
  3: ThumbnailQuality.high,
  4: ThumbnailQuality.max,
};

extension IsarThumbnailQueryFilter
    on QueryBuilder<IsarThumbnail, IsarThumbnail, QFilterCondition> {
  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      heightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      heightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      heightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      heightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      qualityEqualTo(ThumbnailQuality value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      qualityGreaterThan(
    ThumbnailQuality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      qualityLessThan(
    ThumbnailQuality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      qualityBetween(
    ThumbnailQuality lower,
    ThumbnailQuality upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      widthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      widthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      widthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarThumbnail, IsarThumbnail, QAfterFilterCondition>
      widthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension IsarThumbnailQueryObject
    on QueryBuilder<IsarThumbnail, IsarThumbnail, QFilterCondition> {}
