// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_material_color.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarMaterialColorSchema = Schema(
  name: r'IsarMaterialColor',
  id: 131276750436896600,
  properties: {
    r'primary': PropertySchema(
      id: 0,
      name: r'primary',
      type: IsarType.long,
    ),
    r'shade100': PropertySchema(
      id: 1,
      name: r'shade100',
      type: IsarType.long,
    ),
    r'shade200': PropertySchema(
      id: 2,
      name: r'shade200',
      type: IsarType.long,
    ),
    r'shade300': PropertySchema(
      id: 3,
      name: r'shade300',
      type: IsarType.long,
    ),
    r'shade400': PropertySchema(
      id: 4,
      name: r'shade400',
      type: IsarType.long,
    ),
    r'shade50': PropertySchema(
      id: 5,
      name: r'shade50',
      type: IsarType.long,
    ),
    r'shade500': PropertySchema(
      id: 6,
      name: r'shade500',
      type: IsarType.long,
    ),
    r'shade600': PropertySchema(
      id: 7,
      name: r'shade600',
      type: IsarType.long,
    ),
    r'shade700': PropertySchema(
      id: 8,
      name: r'shade700',
      type: IsarType.long,
    ),
    r'shade800': PropertySchema(
      id: 9,
      name: r'shade800',
      type: IsarType.long,
    ),
    r'shade900': PropertySchema(
      id: 10,
      name: r'shade900',
      type: IsarType.long,
    )
  },
  estimateSize: _isarMaterialColorEstimateSize,
  serialize: _isarMaterialColorSerialize,
  deserialize: _isarMaterialColorDeserialize,
  deserializeProp: _isarMaterialColorDeserializeProp,
);

int _isarMaterialColorEstimateSize(
  IsarMaterialColor object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarMaterialColorSerialize(
  IsarMaterialColor object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.primary);
  writer.writeLong(offsets[1], object.shade100);
  writer.writeLong(offsets[2], object.shade200);
  writer.writeLong(offsets[3], object.shade300);
  writer.writeLong(offsets[4], object.shade400);
  writer.writeLong(offsets[5], object.shade50);
  writer.writeLong(offsets[6], object.shade500);
  writer.writeLong(offsets[7], object.shade600);
  writer.writeLong(offsets[8], object.shade700);
  writer.writeLong(offsets[9], object.shade800);
  writer.writeLong(offsets[10], object.shade900);
}

IsarMaterialColor _isarMaterialColorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMaterialColor(
    primary: reader.readLongOrNull(offsets[0]),
    shade100: reader.readLongOrNull(offsets[1]),
    shade200: reader.readLongOrNull(offsets[2]),
    shade300: reader.readLongOrNull(offsets[3]),
    shade400: reader.readLongOrNull(offsets[4]),
    shade50: reader.readLongOrNull(offsets[5]),
    shade500: reader.readLongOrNull(offsets[6]),
    shade600: reader.readLongOrNull(offsets[7]),
    shade700: reader.readLongOrNull(offsets[8]),
    shade800: reader.readLongOrNull(offsets[9]),
    shade900: reader.readLongOrNull(offsets[10]),
  );
  return object;
}

P _isarMaterialColorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarMaterialColorQueryFilter
    on QueryBuilder<IsarMaterialColor, IsarMaterialColor, QFilterCondition> {
  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      primaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'primary',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      primaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'primary',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      primaryEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primary',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      primaryGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primary',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      primaryLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primary',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      primaryBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade100IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade100',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade100IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade100',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade100EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade100',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade100GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade100',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade100LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade100',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade100Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade100',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade200IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade200',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade200IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade200',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade200EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade200',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade200GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade200',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade200LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade200',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade200Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade200',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade300IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade300',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade300IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade300',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade300EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade300',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade300GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade300',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade300LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade300',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade300Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade300',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade400IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade400',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade400IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade400',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade400EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade400',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade400GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade400',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade400LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade400',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade400Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade400',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade50IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade50',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade50IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade50',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade50EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade50',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade50GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade50',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade50LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade50',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade50Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade50',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade500IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade500',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade500IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade500',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade500EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade500',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade500GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade500',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade500LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade500',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade500Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade500',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade600IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade600',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade600IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade600',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade600EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade600',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade600GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade600',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade600LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade600',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade600Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade600',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade700IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade700',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade700IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade700',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade700EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade700',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade700GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade700',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade700LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade700',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade700Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade700',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade800IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade800',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade800IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade800',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade800EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade800',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade800GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade800',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade800LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade800',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade800Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade800',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade900IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shade900',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade900IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shade900',
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade900EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shade900',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade900GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shade900',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade900LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shade900',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMaterialColor, IsarMaterialColor, QAfterFilterCondition>
      shade900Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shade900',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarMaterialColorQueryObject
    on QueryBuilder<IsarMaterialColor, IsarMaterialColor, QFilterCondition> {}
