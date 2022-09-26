import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/models/character.dart';
import 'package:rick_and_morty/character/bloc/character_state.dart';
import 'package:rick_and_morty/character/bloc/character_event.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rick_and_morty/enums.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

// BLOC

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(const CharacterState()) {
    on<CharacterFetchEvent>(
      _onCharacterFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<CharacterResetEvet>(
      _onRemoveAll,
      transformer: throttleDroppable(throttleDuration),
    );
    on<CharacterFetchResidentsEvent>(_onResidentsFetched);
  }

  Future<void> _onResidentsFetched(
      CharacterFetchResidentsEvent event, Emitter<CharacterState> emit) async {
    try {
      final residents = await _fetchResident(event.residentsURLs);
      emit(state.copyWith(
        status: CharacterStatus.success,
        characters: residents,
        hasReachedMax: true,
      ));
    } catch (_) {
      emit(state.copyWith(status: CharacterStatus.failure));
    }
  }

  Future<List<CharacterModel>> _fetchResident(List<String> urls) async {
    int len = urls.length;
    List<CharacterModel> list = [];

    for (int i = 0; i < len; i++) {
      final response = await Dio().get(urls[i]);
      if (response.statusCode == 200) {
        final result = response.data as Map<String, dynamic>;
        list.add(CharacterModel.fromJson(result));
      }
    }
    return list;
  }

  void _onRemoveAll(CharacterResetEvet event, Emitter<CharacterState> emit) {
    emit(const CharacterReset());
  }

  Future<void> _onCharacterFetched(
      CharacterFetchEvent event, Emitter<CharacterState> emit) async {
    try {
      if (state.hasReachedMax) return;
      if (state.status == CharacterStatus.initial) {
        final characters = await _fetchCharacter(
          1,
          event.species,
          event.gender,
          event.status,
        );
        return emit(state.copyWith(
          status: CharacterStatus.success,
          characters: characters,
          hasReachedMax: false,
        ));
      }

      final characters = await _fetchCharacter(
        state.characters.length ~/ 20 + 1,
        event.species,
        event.gender,
        event.status,
      );

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

  Future<List<CharacterModel>> _fetchCharacter([
    int page = 1,
    Species species = Species.any,
    Gender gender = Gender.any,
    Status status = Status.any,
  ]) async {
    Dio dio = Dio(BaseOptions(
      baseUrl: "https://rickandmortyapi.com/api",
      method: 'GET',
    ));
    final response = await dio.request(
      "/character",
      queryParameters: {
        'page': page,
        'status': status == Status.any ? '' : status.name,
        'gender': gender == Gender.any ? '' : gender.name,
        'species': species == Species.any ? '' : species.name,
      },
    );
    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return CharacterModel.fromJson(map);
      }).toList();
    }
    throw Exception('error fetching character');
  }
}
