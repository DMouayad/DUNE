// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_track_month_listening_history.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarMonthListeningHistoryTrackSummarySchema = Schema(
  name: r'IsarMonthListeningHistoryTrackSummary',
  id: 4679879438919118000,
  properties: {
    r'completedListensCount': PropertySchema(
      id: 0,
      name: r'completedListensCount',
      type: IsarType.long,
    ),
    r'totalListeningMinutes': PropertySchema(
      id: 1,
      name: r'totalListeningMinutes',
      type: IsarType.long,
    ),
    r'trackId': PropertySchema(
      id: 2,
      name: r'trackId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarMonthListeningHistoryTrackSummaryEstimateSize,
  serialize: _isarMonthListeningHistoryTrackSummarySerialize,
  deserialize: _isarMonthListeningHistoryTrackSummaryDeserialize,
  deserializeProp: _isarMonthListeningHistoryTrackSummaryDeserializeProp,
);

int _isarMonthListeningHistoryTrackSummaryEstimateSize(
  IsarMonthListeningHistoryTrackSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.trackId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarMonthListeningHistoryTrackSummarySerialize(
  IsarMonthListeningHistoryTrackSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.completedListensCount);
  writer.writeLong(offsets[1], object.totalListeningMinutes);
  writer.writeString(offsets[2], object.trackId);
}

IsarMonthListeningHistoryTrackSummary
    _isarMonthListeningHistoryTrackSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMonthListeningHistoryTrackSummary(
    completedListensCount: reader.readLongOrNull(offsets[0]) ?? 0,
    totalListeningMinutes: reader.readLongOrNull(offsets[1]) ?? 0,
    trackId: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _isarMonthListeningHistoryTrackSummaryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarMonthListeningHistoryTrackSummaryQueryFilter on QueryBuilder<
    IsarMonthListeningHistoryTrackSummary,
    IsarMonthListeningHistoryTrackSummary,
    QFilterCondition> {
  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> completedListensCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedListensCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> completedListensCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedListensCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> completedListensCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedListensCount',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> completedListensCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedListensCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> totalListeningMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalListeningMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> totalListeningMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalListeningMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> totalListeningMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalListeningMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> totalListeningMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalListeningMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackId',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackId',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMonthListeningHistoryTrackSummary,
          IsarMonthListeningHistoryTrackSummary, QAfterFilterCondition>
      trackIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMonthListeningHistoryTrackSummary,
          IsarMonthListeningHistoryTrackSummary, QAfterFilterCondition>
      trackIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: '',
      ));
    });
  }

  QueryBuilder<
      IsarMonthListeningHistoryTrackSummary,
      IsarMonthListeningHistoryTrackSummary,
      QAfterFilterCondition> trackIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackId',
        value: '',
      ));
    });
  }
}

extension IsarMonthListeningHistoryTrackSummaryQueryObject on QueryBuilder<
    IsarMonthListeningHistoryTrackSummary,
    IsarMonthListeningHistoryTrackSummary,
    QFilterCondition> {}
