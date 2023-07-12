import 'base_track.dart';

abstract class BaseTrackRecord<T extends BaseTrack> {
  final T? track;
  final List<ListeningRecord> listeningHistory;

  BaseTrackRecord({required this.listeningHistory, this.track});

  Map<String, dynamic> toMap() {
    return {
      'listeningHistory': this.listeningHistory.map((e) => e.toMap()).toList(),
      'track': this.track,
    };
  }
}

class ListeningRecord {
  final DateTime? date;
  final Duration? uncompletedListensTotalDuration;
  final int? completedListensCount;

  const ListeningRecord({
    this.date,
    this.uncompletedListensTotalDuration,
    this.completedListensCount,
  });

  @override
  String toString() {
    return 'ListeningRecord{date: $date, uncompletedListensTotalDuration:'
        '$uncompletedListensTotalDuration, completedListensCount: $completedListensCount}';
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'uncompletedListensTotalDuration': uncompletedListensTotalDuration,
      'completedListensCount': completedListensCount,
    };
  }

  factory ListeningRecord.fromMap(Map<String, dynamic> map) {
    return ListeningRecord(
      date: DateTime.tryParse(map['date']),
      uncompletedListensTotalDuration:
          map['uncompletedListensTotalDuration'] as Duration?,
      completedListensCount: map['completedListensCount'] as int?,
    );
  }
}
