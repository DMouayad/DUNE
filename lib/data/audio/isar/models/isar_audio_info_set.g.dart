// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_audio_info_set.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarAudioInfoSetSchema = Schema(
  name: r'IsarAudioInfoSet',
  id: -8066112321837386798,
  properties: {
    r'isarAudioInfoList': PropertySchema(
      id: 0,
      name: r'isarAudioInfoList',
      type: IsarType.objectList,
      target: r'IsarTrackAudioInfo',
    )
  },
  estimateSize: _isarAudioInfoSetEstimateSize,
  serialize: _isarAudioInfoSetSerialize,
  deserialize: _isarAudioInfoSetDeserialize,
  deserializeProp: _isarAudioInfoSetDeserializeProp,
);

int _isarAudioInfoSetEstimateSize(
  IsarAudioInfoSet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.isarAudioInfoList.length * 3;
  {
    final offsets = allOffsets[IsarTrackAudioInfo]!;
    for (var i = 0; i < object.isarAudioInfoList.length; i++) {
      final value = object.isarAudioInfoList[i];
      bytesCount +=
          IsarTrackAudioInfoSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _isarAudioInfoSetSerialize(
  IsarAudioInfoSet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<IsarTrackAudioInfo>(
    offsets[0],
    allOffsets,
    IsarTrackAudioInfoSchema.serialize,
    object.isarAudioInfoList,
  );
}

IsarAudioInfoSet _isarAudioInfoSetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarAudioInfoSet(
    isarAudioInfoList: reader.readObjectList<IsarTrackAudioInfo>(
          offsets[0],
          IsarTrackAudioInfoSchema.deserialize,
          allOffsets,
          IsarTrackAudioInfo(),
        ) ??
        const [],
  );
  return object;
}

P _isarAudioInfoSetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<IsarTrackAudioInfo>(
            offset,
            IsarTrackAudioInfoSchema.deserialize,
            allOffsets,
            IsarTrackAudioInfo(),
          ) ??
          const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarAudioInfoSetQueryFilter
    on QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QFilterCondition> {
  QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QAfterFilterCondition>
      isarAudioInfoListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarAudioInfoList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QAfterFilterCondition>
      isarAudioInfoListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarAudioInfoList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QAfterFilterCondition>
      isarAudioInfoListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarAudioInfoList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QAfterFilterCondition>
      isarAudioInfoListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarAudioInfoList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QAfterFilterCondition>
      isarAudioInfoListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarAudioInfoList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QAfterFilterCondition>
      isarAudioInfoListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'isarAudioInfoList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension IsarAudioInfoSetQueryObject
    on QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QFilterCondition> {
  QueryBuilder<IsarAudioInfoSet, IsarAudioInfoSet, QAfterFilterCondition>
      isarAudioInfoListElement(FilterQuery<IsarTrackAudioInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'isarAudioInfoList');
    });
  }
}
