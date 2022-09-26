import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/character/models/character.dart';
import 'package:rick_and_morty/character/models/episode.dart';

enum CharacterStatus { initial, success, failure }

class CharacterState extends Equatable {
  const CharacterState({
    this.status = CharacterStatus.initial,
    this.characters = const <CharacterModel>[],
    this.hasReachedMax = false,
    this.episodes = const <EpisodeModel>[],
  });

  final CharacterStatus status;
  final List<CharacterModel> characters;
  final bool hasReachedMax;
  final List<EpisodeModel> episodes;

  CharacterState copyWith({
    CharacterStatus? status,
    List<CharacterModel>? characters,
    bool? hasReachedMax,
    List<EpisodeModel>? episodes,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      episodes: episodes ?? this.episodes,
    );
  }

  @override
  String toString() {
    return '''CharacterState { status: $status, hasReachedMax: $hasReachedMax, characters: ${characters.length} }''';
  }

  @override
  List<Object> get props => [status, characters, hasReachedMax];
}

class CharacterReset extends CharacterState {
  const CharacterReset()
      : super(
          status: CharacterStatus.initial,
          characters: const <CharacterModel>[],
          hasReachedMax: false,
        );

  @override
  List<Object> get props => [status, characters, hasReachedMax];
}
