// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_app_theme.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarAppThemeCollection on Isar {
  IsarCollection<IsarAppTheme> get isarAppThemes => this.collection();
}

const IsarAppThemeSchema = CollectionSchema(
  name: r'IsarAppTheme',
  id: 930812106080800971,
  properties: {
    r'themeMode': PropertySchema(
      id: 0,
      name: r'themeMode',
      type: IsarType.byte,
      enumMap: _IsarAppThemethemeModeEnumValueMap,
    ),
    r'windowEffect': PropertySchema(
      id: 1,
      name: r'windowEffect',
      type: IsarType.byte,
      enumMap: _IsarAppThemewindowEffectEnumValueMap,
    )
  },
  estimateSize: _isarAppThemeEstimateSize,
  serialize: _isarAppThemeSerialize,
  deserialize: _isarAppThemeDeserialize,
  deserializeProp: _isarAppThemeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarAppThemeGetId,
  getLinks: _isarAppThemeGetLinks,
  attach: _isarAppThemeAttach,
  version: '3.1.0+1',
);

int _isarAppThemeEstimateSize(
  IsarAppTheme object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarAppThemeSerialize(
  IsarAppTheme object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.themeMode.index);
  writer.writeByte(offsets[1], object.windowEffect.index);
}

IsarAppTheme _isarAppThemeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarAppTheme(
    id: id,
    themeMode:
        _IsarAppThemethemeModeValueEnumMap[reader.readByteOrNull(offsets[0])] ??
            ThemeMode.system,
    windowEffect: _IsarAppThemewindowEffectValueEnumMap[
            reader.readByteOrNull(offsets[1])] ??
        WindowEffect.solid,
  );
  return object;
}

P _isarAppThemeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_IsarAppThemethemeModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ThemeMode.system) as P;
    case 1:
      return (_IsarAppThemewindowEffectValueEnumMap[
              reader.readByteOrNull(offset)] ??
          WindowEffect.solid) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarAppThemethemeModeEnumValueMap = {
  'system': 0,
  'light': 1,
  'dark': 2,
};
const _IsarAppThemethemeModeValueEnumMap = {
  0: ThemeMode.system,
  1: ThemeMode.light,
  2: ThemeMode.dark,
};
const _IsarAppThemewindowEffectEnumValueMap = {
  'disabled': 0,
  'solid': 1,
  'transparent': 2,
  'aero': 3,
  'acrylic': 4,
  'mica': 5,
  'tabbed': 6,
  'titlebar': 7,
  'selection': 8,
  'menu': 9,
  'popover': 10,
  'sidebar': 11,
  'headerView': 12,
  'sheet': 13,
  'windowBackground': 14,
  'hudWindow': 15,
  'fullScreenUI': 16,
  'toolTip': 17,
  'contentBackground': 18,
  'underWindowBackground': 19,
  'underPageBackground': 20,
};
const _IsarAppThemewindowEffectValueEnumMap = {
  0: WindowEffect.disabled,
  1: WindowEffect.solid,
  2: WindowEffect.transparent,
  3: WindowEffect.aero,
  4: WindowEffect.acrylic,
  5: WindowEffect.mica,
  6: WindowEffect.tabbed,
  7: WindowEffect.titlebar,
  8: WindowEffect.selection,
  9: WindowEffect.menu,
  10: WindowEffect.popover,
  11: WindowEffect.sidebar,
  12: WindowEffect.headerView,
  13: WindowEffect.sheet,
  14: WindowEffect.windowBackground,
  15: WindowEffect.hudWindow,
  16: WindowEffect.fullScreenUI,
  17: WindowEffect.toolTip,
  18: WindowEffect.contentBackground,
  19: WindowEffect.underWindowBackground,
  20: WindowEffect.underPageBackground,
};

Id _isarAppThemeGetId(IsarAppTheme object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarAppThemeGetLinks(IsarAppTheme object) {
  return [];
}

void _isarAppThemeAttach(
    IsarCollection<dynamic> col, Id id, IsarAppTheme object) {}

extension IsarAppThemeQueryWhereSort
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QWhere> {
  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarAppThemeQueryWhere
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QWhereClause> {
  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterWhereClause> idBetween(
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

extension IsarAppThemeQueryFilter
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QFilterCondition> {
  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      themeModeEqualTo(ThemeMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      themeModeGreaterThan(
    ThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      themeModeLessThan(
    ThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      themeModeBetween(
    ThemeMode lower,
    ThemeMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      windowEffectEqualTo(WindowEffect value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'windowEffect',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      windowEffectGreaterThan(
    WindowEffect value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'windowEffect',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      windowEffectLessThan(
    WindowEffect value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'windowEffect',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterFilterCondition>
      windowEffectBetween(
    WindowEffect lower,
    WindowEffect upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'windowEffect',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarAppThemeQueryObject
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QFilterCondition> {}

extension IsarAppThemeQueryLinks
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QFilterCondition> {}

extension IsarAppThemeQuerySortBy
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QSortBy> {
  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> sortByWindowEffect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowEffect', Sort.asc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy>
      sortByWindowEffectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowEffect', Sort.desc);
    });
  }
}

extension IsarAppThemeQuerySortThenBy
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QSortThenBy> {
  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy> thenByWindowEffect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowEffect', Sort.asc);
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QAfterSortBy>
      thenByWindowEffectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windowEffect', Sort.desc);
    });
  }
}

extension IsarAppThemeQueryWhereDistinct
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QDistinct> {
  QueryBuilder<IsarAppTheme, IsarAppTheme, QDistinct> distinctByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode');
    });
  }

  QueryBuilder<IsarAppTheme, IsarAppTheme, QDistinct> distinctByWindowEffect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'windowEffect');
    });
  }
}

extension IsarAppThemeQueryProperty
    on QueryBuilder<IsarAppTheme, IsarAppTheme, QQueryProperty> {
  QueryBuilder<IsarAppTheme, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarAppTheme, ThemeMode, QQueryOperations> themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }

  QueryBuilder<IsarAppTheme, WindowEffect, QQueryOperations>
      windowEffectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'windowEffect');
    });
  }
}
