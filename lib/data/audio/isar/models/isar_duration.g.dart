// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_duration.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarDurationSchema = Schema(
  name: r'IsarDuration',
  id: 5916644251011279715,
  properties: {
    r'inSeconds': PropertySchema(
      id: 0,
      name: r'inSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _isarDurationEstimateSize,
  serialize: _isarDurationSerialize,
  deserialize: _isarDurationDeserialize,
  deserializeProp: _isarDurationDeserializeProp,
);

int _isarDurationEstimateSize(
  IsarDuration object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarDurationSerialize(
  IsarDuration object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.inSeconds);
}

IsarDuration _isarDurationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarDuration(
    inSeconds: reader.readLongOrNull(offsets[0]) ?? 0,
  );
  return object;
}

P _isarDurationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarDurationQueryFilter
    on QueryBuilder<IsarDuration, IsarDuration, QFilterCondition> {
  QueryBuilder<IsarDuration, IsarDuration, QAfterFilterCondition>
      inSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDuration, IsarDuration, QAfterFilterCondition>
      inSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDuration, IsarDuration, QAfterFilterCondition>
      inSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDuration, IsarDuration, QAfterFilterCondition>
      inSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarDurationQueryObject
    on QueryBuilder<IsarDuration, IsarDuration, QFilterCondition> {}
