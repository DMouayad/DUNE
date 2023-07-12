enum AudioStreamingQuality {
  undefined,
  lowest,
  low,
  balanced,
  high,
  best;

  static List<AudioStreamingQuality> get lowQualityGroup {
    return [lowest, low, balanced];
  }

  static List<AudioStreamingQuality> get highQualityGroup {
    return [high, best];
  }

  static List<AudioStreamingQuality> get withoutUndefined {
    final modified = List<AudioStreamingQuality>.from(values);
    modified.remove(undefined);
    return modified;
  }
}
