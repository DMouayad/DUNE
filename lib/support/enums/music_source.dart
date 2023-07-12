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

  static List<MusicSource> get withoutUnknown => [youtube, spotify, local];
}
