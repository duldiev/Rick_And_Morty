import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/models/character.dart';
import 'package:rick_and_morty/character/bloc/character_state.dart';
import 'package:rick_and_morty/character/bloc/character_event.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {

  CharacterBloc() : super(const CharacterState()) {
    on<CharacterFetchEvent>(
      _onCharacterFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onCharacterFetched(
      CharacterFetchEvent event, Emitter<CharacterState> emit) async {
    try {
      if (state.hasReachedMax) return;
      if (state.status == CharacterStatus.initial) {
        final characters = await _fetchCharacter();
        return emit(state.copyWith(
          status: CharacterStatus.success,
          characters: characters,
          hasReachedMax: false,
        ));
      }
      final characters = await _fetchCharacter(state.characters.length ~/ 20 + 1);
      emit(characters.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: CharacterStatus.success,
              characters: List.of(state.characters)..addAll(characters),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: CharacterStatus.failure));
    }
  }

  Future<List<CharacterModel>> _fetchCharacter([int page = 1]) async {
    final response = await Dio().get("https://rickandmortyapi.com/api/character?page=$page");
    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return CharacterModel.fromJson(map);
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
