import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'isar_duration.g.dart';

@Embedded(ignore: {'props', 'derived', 'hashCode', 'stringify'})
class IsarDuration extends Equatable {
  final int inSeconds;

  const IsarDuration({this.inSeconds = 0});

  @override
  List<Object?> get props => [inSeconds];
}
