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

  bool get isOnline {
    return [youtube, spotify].contains(this);
  }

  static List<MusicSource> get valuesWithoutUnknown =>
      [youtube, spotify, local];

  static List<MusicSource> get remoteSources => [youtube, spotify];
}
