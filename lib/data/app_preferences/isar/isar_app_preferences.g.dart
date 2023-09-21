// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_app_preferences.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarAppPreferencesCollection on Isar {
  IsarCollection<IsarAppPreferences> get isarAppPreferences =>
      this.collection();
}

const IsarAppPreferencesSchema = CollectionSchema(
  name: r'IsarAppPreferences',
  id: 2395131297843833462,
  properties: {
    r'audioStreamingQuality': PropertySchema(
      id: 0,
      name: r'audioStreamingQuality',
      type: IsarType.byte,
      enumMap: _IsarAppPreferencesaudioStreamingQualityEnumValueMap,
    ),
    r'exploreMusicSource': PropertySchema(
      id: 1,
      name: r'exploreMusicSource',
      type: IsarType.byte,
      enumMap: _IsarAppPreferencesexploreMusicSourceEnumValueMap,
    ),
    r'initialPageOnStartup': PropertySchema(
      id: 2,
      name: r'initialPageOnStartup',
      type: IsarType.byte,
      enumMap: _IsarAppPreferencesinitialPageOnStartupEnumValueMap,
    ),
    r'lastSidePanelWidth': PropertySchema(
      id: 3,
      name: r'lastSidePanelWidth',
      type: IsarType.double,
    ),
    r'lastWindowHeight': PropertySchema(
      id: 4,
      name: r'lastWindowHeight',
      type: IsarType.double,
    ),
    r'lastWindowWidth': PropertySchema(
      id: 5,
      name: r'lastWindowWidth',
      type: IsarType.double,
    ),
    r'localMusicFoldersList': PropertySchema(
      id: 6,
      name: r'localMusicFoldersList',
      type: IsarType.objectList,
      target: r'IsarMusicFolder',
    ),
    r'rememberLastSidePanelSize': PropertySchema(
      id: 7,
      name: r'rememberLastSidePanelSize',
      type: IsarType.bool,
    ),
    r'rememberLastWindowSize': PropertySchema(
      id: 8,
      name: r'rememberLastWindowSize',
      type: IsarType.bool,
    ),
    r'searchEngine': PropertySchema(
      id: 9,
      name: r'searchEngine',
      type: IsarType.byte,
      enumMap: _IsarAppPreferencessearchEngineEnumValueMap,
    ),
    r'tabsMode': PropertySchema(
      id: 10,
      name: r'tabsMode',
      type: IsarType.byte,
      enumMap: _IsarAppPreferencestabsModeEnumValueMap,
    ),
    r'thumbnailQualitiesOrder': PropertySchema(
      id: 11,
      name: r'thumbnailQualitiesOrder',
      type: IsarType.byte,
      enumMap: _IsarAppPreferencesthumbnailQualitiesOrderEnumValueMap,
    ),
    r'usePrimaryColorInCardColor': PropertySchema(
      id: 12,
      name: r'usePrimaryColorInCardColor',
      type: IsarType.bool,
    ),
    r'volumeStep': PropertySchema(
      id: 13,
      name: r'volumeStep',
      type: IsarType.double,
    )
  },
  estimateSize: _isarAppPreferencesEstimateSize,
  serialize: _isarAppPreferencesSerialize,
  deserialize: _isarAppPreferencesDeserialize,
  deserializeProp: _isarAppPreferencesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'IsarMusicFolder': IsarMusicFolderSchema},
  getId: _isarAppPreferencesGetId,
  getLinks: _isarAppPreferencesGetLinks,
  attach: _isarAppPreferencesAttach,
  version: '3.1.0+1',
);

int _isarAppPreferencesEstimateSize(
  IsarAppPreferences object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.localMusicFoldersList.length * 3;
  {
    final offsets = allOffsets[IsarMusicFolder]!;
    for (var i = 0; i < object.localMusicFoldersList.length; i++) {
      final value = object.localMusicFoldersList[i];
      bytesCount +=
          IsarMusicFolderSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _isarAppPreferencesSerialize(
  IsarAppPreferences object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.audioStreamingQuality.index);
  writer.writeByte(offsets[1], object.exploreMusicSource.index);
  writer.writeByte(offsets[2], object.initialPageOnStartup.index);
  writer.writeDouble(offsets[3], object.lastSidePanelWidth);
  writer.writeDouble(offsets[4], object.lastWindowHeight);
  writer.writeDouble(offsets[5], object.lastWindowWidth);
  writer.writeObjectList<IsarMusicFolder>(
    offsets[6],
    allOffsets,
    IsarMusicFolderSchema.serialize,
    object.localMusicFoldersList,
  );
  writer.writeBool(offsets[7], object.rememberLastSidePanelSize);
  writer.writeBool(offsets[8], object.rememberLastWindowSize);
  writer.writeByte(offsets[9], object.searchEngine.index);
  writer.writeByte(offsets[10], object.tabsMode.index);
  writer.writeByte(offsets[11], object.thumbnailQualitiesOrder.index);
  writer.writeBool(offsets[12], object.usePrimaryColorInCardColor);
  writer.writeDouble(offsets[13], object.volumeStep);
}

IsarAppPreferences _isarAppPreferencesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarAppPreferences(
    audioStreamingQuality: _IsarAppPreferencesaudioStreamingQualityValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        AudioStreamingQuality.balanced,
    exploreMusicSource: _IsarAppPreferencesexploreMusicSourceValueEnumMap[
            reader.readByteOrNull(offsets[1])] ??
        MusicSource.youtube,
    id: id,
    initialPageOnStartup: _IsarAppPreferencesinitialPageOnStartupValueEnumMap[
            reader.readByteOrNull(offsets[2])] ??
        InitialPageOnStartup.exploreMusic,
    lastSidePanelWidth: reader.readDoubleOrNull(offsets[3]),
    lastWindowHeight: reader.readDoubleOrNull(offsets[4]),
    lastWindowWidth: reader.readDoubleOrNull(offsets[5]),
    localMusicFoldersList: reader.readObjectList<IsarMusicFolder>(
          offsets[6],
          IsarMusicFolderSchema.deserialize,
          allOffsets,
          IsarMusicFolder(),
        ) ??
        const [],
    rememberLastSidePanelSize: reader.readBoolOrNull(offsets[7]) ?? true,
    rememberLastWindowSize: reader.readBoolOrNull(offsets[8]) ?? true,
    searchEngine: _IsarAppPreferencessearchEngineValueEnumMap[
            reader.readByteOrNull(offsets[9])] ??
        MusicSource.youtube,
    tabsMode: _IsarAppPreferencestabsModeValueEnumMap[
            reader.readByteOrNull(offsets[10])] ??
        TabsMode.vertical,
    thumbnailQualitiesOrder:
        _IsarAppPreferencesthumbnailQualitiesOrderValueEnumMap[
                reader.readByteOrNull(offsets[11])] ??
            ThumbnailQualitiesOrderOption.balanced,
    usePrimaryColorInCardColor: reader.readBoolOrNull(offsets[12]) ?? true,
    volumeStep: reader.readDoubleOrNull(offsets[13]) ?? 5.0,
  );
  return object;
}

P _isarAppPreferencesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_IsarAppPreferencesaudioStreamingQualityValueEnumMap[
              reader.readByteOrNull(offset)] ??
          AudioStreamingQuality.balanced) as P;
    case 1:
      return (_IsarAppPreferencesexploreMusicSourceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MusicSource.youtube) as P;
    case 2:
      return (_IsarAppPreferencesinitialPageOnStartupValueEnumMap[
              reader.readByteOrNull(offset)] ??
          InitialPageOnStartup.exploreMusic) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readObjectList<IsarMusicFolder>(
            offset,
            IsarMusicFolderSchema.deserialize,
            allOffsets,
            IsarMusicFolder(),
          ) ??
          const []) as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 9:
      return (_IsarAppPreferencessearchEngineValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MusicSource.youtube) as P;
    case 10:
      return (_IsarAppPreferencestabsModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TabsMode.vertical) as P;
    case 11:
      return (_IsarAppPreferencesthumbnailQualitiesOrderValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ThumbnailQualitiesOrderOption.balanced) as P;
    case 12:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 13:
      return (reader.readDoubleOrNull(offset) ?? 5.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarAppPreferencesaudioStreamingQualityEnumValueMap = {
  'undefined': 0,
  'lowest': 1,
  'low': 2,
  'balanced': 3,
  'high': 4,
  'best': 5,
};
const _IsarAppPreferencesaudioStreamingQualityValueEnumMap = {
  0: AudioStreamingQuality.undefined,
  1: AudioStreamingQuality.lowest,
  2: AudioStreamingQuality.low,
  3: AudioStreamingQuality.balanced,
  4: AudioStreamingQuality.high,
  5: AudioStreamingQuality.best,
};
const _IsarAppPreferencesexploreMusicSourceEnumValueMap = {
  'youtube': 0,
  'spotify': 1,
  'local': 2,
  'unknown': 3,
};
const _IsarAppPreferencesexploreMusicSourceValueEnumMap = {
  0: MusicSource.youtube,
  1: MusicSource.spotify,
  2: MusicSource.local,
  3: MusicSource.unknown,
};
const _IsarAppPreferencesinitialPageOnStartupEnumValueMap = {
  'exploreMusic': 0,
  'myLibrary': 1,
};
const _IsarAppPreferencesinitialPageOnStartupValueEnumMap = {
  0: InitialPageOnStartup.exploreMusic,
  1: InitialPageOnStartup.myLibrary,
};
const _IsarAppPreferencessearchEngineEnumValueMap = {
  'youtube': 0,
  'spotify': 1,
  'local': 2,
  'unknown': 3,
};
const _IsarAppPreferencessearchEngineValueEnumMap = {
  0: MusicSource.youtube,
  1: MusicSource.spotify,
  2: MusicSource.local,
  3: MusicSource.unknown,
};
const _IsarAppPreferencestabsModeEnumValueMap = {
  'disabled': 0,
  'vertical': 1,
  'horizontal': 2,
};
const _IsarAppPreferencestabsModeValueEnumMap = {
  0: TabsMode.disabled,
  1: TabsMode.vertical,
  2: TabsMode.horizontal,
};
const _IsarAppPreferencesthumbnailQualitiesOrderEnumValueMap = {
  'best': 0,
  'balanced': 1,
  'lowest': 2,
};
const _IsarAppPreferencesthumbnailQualitiesOrderValueEnumMap = {
  0: ThumbnailQualitiesOrderOption.best,
  1: ThumbnailQualitiesOrderOption.balanced,
  2: ThumbnailQualitiesOrderOption.lowest,
};

Id _isarAppPreferencesGetId(IsarAppPreferences object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _isarAppPreferencesGetLinks(
    IsarAppPreferences object) {
  return [];
}

void _isarAppPreferencesAttach(
    IsarCollection<dynamic> col, Id id, IsarAppPreferences object) {
  object.id = id;
}

extension IsarAppPreferencesQueryWhereSort
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QWhere> {
  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarAppPreferencesQueryWhere
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QWhereClause> {
  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterWhereClause>
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

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterWhereClause>
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
}

extension IsarAppPreferencesQueryFilter
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QFilterCondition> {
  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      audioStreamingQualityEqualTo(AudioStreamingQuality value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioStreamingQuality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      audioStreamingQualityGreaterThan(
    AudioStreamingQuality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioStreamingQuality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      audioStreamingQualityLessThan(
    AudioStreamingQuality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioStreamingQuality',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      audioStreamingQualityBetween(
    AudioStreamingQuality lower,
    AudioStreamingQuality upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioStreamingQuality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      exploreMusicSourceEqualTo(MusicSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exploreMusicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      exploreMusicSourceGreaterThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exploreMusicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      exploreMusicSourceLessThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exploreMusicSource',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      exploreMusicSourceBetween(
    MusicSource lower,
    MusicSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exploreMusicSource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      initialPageOnStartupEqualTo(InitialPageOnStartup value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initialPageOnStartup',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      initialPageOnStartupGreaterThan(
    InitialPageOnStartup value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'initialPageOnStartup',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      initialPageOnStartupLessThan(
    InitialPageOnStartup value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'initialPageOnStartup',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      initialPageOnStartupBetween(
    InitialPageOnStartup lower,
    InitialPageOnStartup upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'initialPageOnStartup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastSidePanelWidthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSidePanelWidth',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastSidePanelWidthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSidePanelWidth',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastSidePanelWidthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSidePanelWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastSidePanelWidthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSidePanelWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastSidePanelWidthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSidePanelWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastSidePanelWidthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSidePanelWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowHeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastWindowHeight',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowHeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastWindowHeight',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowHeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastWindowHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowHeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastWindowHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowHeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastWindowHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowHeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastWindowHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowWidthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastWindowWidth',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowWidthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastWindowWidth',
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowWidthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastWindowWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowWidthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastWindowWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowWidthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastWindowWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      lastWindowWidthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastWindowWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      localMusicFoldersListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localMusicFoldersList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      localMusicFoldersListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localMusicFoldersList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      localMusicFoldersListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localMusicFoldersList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      localMusicFoldersListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localMusicFoldersList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      localMusicFoldersListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localMusicFoldersList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      localMusicFoldersListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localMusicFoldersList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      rememberLastSidePanelSizeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rememberLastSidePanelSize',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      rememberLastWindowSizeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rememberLastWindowSize',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      searchEngineEqualTo(MusicSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchEngine',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      searchEngineGreaterThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchEngine',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      searchEngineLessThan(
    MusicSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchEngine',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      searchEngineBetween(
    MusicSource lower,
    MusicSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchEngine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      tabsModeEqualTo(TabsMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tabsMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      tabsModeGreaterThan(
    TabsMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tabsMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      tabsModeLessThan(
    TabsMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tabsMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      tabsModeBetween(
    TabsMode lower,
    TabsMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tabsMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      thumbnailQualitiesOrderEqualTo(ThumbnailQualitiesOrderOption value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailQualitiesOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      thumbnailQualitiesOrderGreaterThan(
    ThumbnailQualitiesOrderOption value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailQualitiesOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      thumbnailQualitiesOrderLessThan(
    ThumbnailQualitiesOrderOption value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailQualitiesOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      thumbnailQualitiesOrderBetween(
    ThumbnailQualitiesOrderOption lower,
    ThumbnailQualitiesOrderOption upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailQualitiesOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      usePrimaryColorInCardColorEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usePrimaryColorInCardColor',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      volumeStepEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volumeStep',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      volumeStepGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'volumeStep',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      volumeStepLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'volumeStep',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      volumeStepBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'volumeStep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension IsarAppPreferencesQueryObject
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QFilterCondition> {
  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterFilterCondition>
      localMusicFoldersListElement(FilterQuery<IsarMusicFolder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'localMusicFoldersList');
    });
  }
}

extension IsarAppPreferencesQueryLinks
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QFilterCondition> {}

extension IsarAppPreferencesQuerySortBy
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QSortBy> {
  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByAudioStreamingQuality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStreamingQuality', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByAudioStreamingQualityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStreamingQuality', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByExploreMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exploreMusicSource', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByExploreMusicSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exploreMusicSource', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByInitialPageOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialPageOnStartup', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByInitialPageOnStartupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialPageOnStartup', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByLastSidePanelWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSidePanelWidth', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByLastSidePanelWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSidePanelWidth', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByLastWindowHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowHeight', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByLastWindowHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowHeight', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByLastWindowWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowWidth', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByLastWindowWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowWidth', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByRememberLastSidePanelSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastSidePanelSize', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByRememberLastSidePanelSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastSidePanelSize', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByRememberLastWindowSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastWindowSize', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByRememberLastWindowSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastWindowSize', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortBySearchEngine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchEngine', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortBySearchEngineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchEngine', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByTabsMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabsMode', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByTabsModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabsMode', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByThumbnailQualitiesOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailQualitiesOrder', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByThumbnailQualitiesOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailQualitiesOrder', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByUsePrimaryColorInCardColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usePrimaryColorInCardColor', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByUsePrimaryColorInCardColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usePrimaryColorInCardColor', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByVolumeStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeStep', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      sortByVolumeStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeStep', Sort.desc);
    });
  }
}

extension IsarAppPreferencesQuerySortThenBy
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QSortThenBy> {
  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByAudioStreamingQuality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStreamingQuality', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByAudioStreamingQualityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioStreamingQuality', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByExploreMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exploreMusicSource', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByExploreMusicSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exploreMusicSource', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByInitialPageOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialPageOnStartup', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByInitialPageOnStartupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialPageOnStartup', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByLastSidePanelWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSidePanelWidth', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByLastSidePanelWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSidePanelWidth', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByLastWindowHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowHeight', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByLastWindowHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowHeight', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByLastWindowWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowWidth', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByLastWindowWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWindowWidth', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByRememberLastSidePanelSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastSidePanelSize', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByRememberLastSidePanelSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastSidePanelSize', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByRememberLastWindowSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastWindowSize', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByRememberLastWindowSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rememberLastWindowSize', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenBySearchEngine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchEngine', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenBySearchEngineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchEngine', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByTabsMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabsMode', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByTabsModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tabsMode', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByThumbnailQualitiesOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailQualitiesOrder', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByThumbnailQualitiesOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailQualitiesOrder', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByUsePrimaryColorInCardColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usePrimaryColorInCardColor', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByUsePrimaryColorInCardColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usePrimaryColorInCardColor', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByVolumeStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeStep', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QAfterSortBy>
      thenByVolumeStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeStep', Sort.desc);
    });
  }
}

extension IsarAppPreferencesQueryWhereDistinct
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct> {
  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByAudioStreamingQuality() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioStreamingQuality');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByExploreMusicSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exploreMusicSource');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByInitialPageOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initialPageOnStartup');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByLastSidePanelWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSidePanelWidth');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByLastWindowHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastWindowHeight');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByLastWindowWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastWindowWidth');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByRememberLastSidePanelSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rememberLastSidePanelSize');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByRememberLastWindowSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rememberLastWindowSize');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctBySearchEngine() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchEngine');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByTabsMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tabsMode');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByThumbnailQualitiesOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbnailQualitiesOrder');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByUsePrimaryColorInCardColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usePrimaryColorInCardColor');
    });
  }

  QueryBuilder<IsarAppPreferences, IsarAppPreferences, QDistinct>
      distinctByVolumeStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'volumeStep');
    });
  }
}

extension IsarAppPreferencesQueryProperty
    on QueryBuilder<IsarAppPreferences, IsarAppPreferences, QQueryProperty> {
  QueryBuilder<IsarAppPreferences, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarAppPreferences, AudioStreamingQuality, QQueryOperations>
      audioStreamingQualityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioStreamingQuality');
    });
  }

  QueryBuilder<IsarAppPreferences, MusicSource, QQueryOperations>
      exploreMusicSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exploreMusicSource');
    });
  }

  QueryBuilder<IsarAppPreferences, InitialPageOnStartup, QQueryOperations>
      initialPageOnStartupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initialPageOnStartup');
    });
  }

  QueryBuilder<IsarAppPreferences, double?, QQueryOperations>
      lastSidePanelWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSidePanelWidth');
    });
  }

  QueryBuilder<IsarAppPreferences, double?, QQueryOperations>
      lastWindowHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastWindowHeight');
    });
  }

  QueryBuilder<IsarAppPreferences, double?, QQueryOperations>
      lastWindowWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastWindowWidth');
    });
  }

  QueryBuilder<IsarAppPreferences, List<IsarMusicFolder>, QQueryOperations>
      localMusicFoldersListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localMusicFoldersList');
    });
  }

  QueryBuilder<IsarAppPreferences, bool, QQueryOperations>
      rememberLastSidePanelSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rememberLastSidePanelSize');
    });
  }

  QueryBuilder<IsarAppPreferences, bool, QQueryOperations>
      rememberLastWindowSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rememberLastWindowSize');
    });
  }

  QueryBuilder<IsarAppPreferences, MusicSource, QQueryOperations>
      searchEngineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchEngine');
    });
  }

  QueryBuilder<IsarAppPreferences, TabsMode, QQueryOperations>
      tabsModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tabsMode');
    });
  }

  QueryBuilder<IsarAppPreferences, ThumbnailQualitiesOrderOption,
      QQueryOperations> thumbnailQualitiesOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailQualitiesOrder');
    });
  }

  QueryBuilder<IsarAppPreferences, bool, QQueryOperations>
      usePrimaryColorInCardColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usePrimaryColorInCardColor');
    });
  }

  QueryBuilder<IsarAppPreferences, double, QQueryOperations>
      volumeStepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'volumeStep');
    });
  }
}
