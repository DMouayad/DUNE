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
    r'thumbnails': PropertySchema(
      id: 0,
      name: r'thumbnails',
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
    object.thumbnails,
  );
}

IsarThumbnailsSet _isarThumbnailsSetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarThumbnailsSet();
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
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarThumbnailsSetQueryFilter
    on QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QFilterCondition> {
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
}

extension IsarThumbnailsSetQueryObject
    on QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QFilterCondition> {
  QueryBuilder<IsarThumbnailsSet, IsarThumbnailsSet, QAfterFilterCondition>
      thumbnailsElement(FilterQuery<IsarThumbnail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnails');
    });
  }
}
