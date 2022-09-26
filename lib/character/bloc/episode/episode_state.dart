import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/character/models/character.dart';
import 'package:rick_and_morty/character/models/episode.dart';

enum EpisodeStatus { initial, success, failure }

class EpisodeState extends Equatable {
  const EpisodeState({
    this.status = EpisodeStatus.initial,
    this.episodes = const <EpisodeModel>[],
  });

  final EpisodeStatus status;
  final List<EpisodeModel> episodes;

  EpisodeState copyWith({
    EpisodeStatus? status,
    List<EpisodeModel>? episodes,
  }) {
    return EpisodeState(
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
    );
  }

  @override
  String toString() {
    return '''CharacterState { status: $status, episodes: ${episodes.length} }''';
  }

  @override
  List<Object> get props => [status, episodes];
}

class EpisodeReset extends EpisodeState {
  const EpisodeReset()
      : super(
          status: EpisodeStatus.initial,
          episodes: const <EpisodeModel>[],
        );

  @override
  List<Object> get props => [status, episodes];
}
