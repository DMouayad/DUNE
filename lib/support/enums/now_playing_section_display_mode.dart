enum NowPlayingSectionDisplayMode {
  pinned,
  unpinned,
  hidden;

  bool get isPinned => this == pinned;

  bool get isUnpinned => this == unpinned;

  bool get isHidden => this == hidden;
}
