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
    r'thumbnailsList': PropertySchema(
      id: 0,
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
  writer.writeObjectList<IsarThumbnail>(
    offsets[0],
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
          offsets[0],
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
      thumbnailsListElement(FilterQuery<IsarThumbnail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnailsList');
    });
  }
}
