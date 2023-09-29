enum MusicSource {
  youtube,
  spotify,
  local,
  unknown;

  bool get isUnknown {
    return this == unknown;
  }

  bool get isLocal {
    return this == local;
  }

  bool get isRemote {
    return [youtube, spotify].contains(this);
  }

  static MusicSource byNameOrUnknown(String? name) {
    if (name == null) return MusicSource.unknown;
    try {
      return values.byName(name);
    } catch (_) {
      return MusicSource.unknown;
    }
  }

  static List<MusicSource> get valuesWithoutUnknown =>
      [youtube, spotify, local];

  static List<MusicSource> get remoteSources => [youtube, spotify];
}
