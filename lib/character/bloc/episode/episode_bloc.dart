import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/models/episode.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'episode_event.dart';
import 'episode_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

// BLOC

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  EpisodeBloc() : super(const EpisodeState()) {
    on<EpisodeFetchEvent>(
      _onEpisodeFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EpisodeResetEvet>(
      _onReset,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onEpisodeFetched(
      EpisodeFetchEvent event, Emitter<EpisodeState> emit) async {
    try {
      final residents = await _fetchEpisodes(event.urls);
      emit(state.copyWith(
        status: EpisodeStatus.success,
        episodes: residents,
      ));
    } catch (_) {
      emit(state.copyWith(status: EpisodeStatus.failure));
    }
  }

  Future<List<EpisodeModel>> _fetchEpisodes(List<String> urls) async {
    int len = urls.length;
    List<EpisodeModel> list = [];

    for (int i = 0; i < len; i++) {
      final response = await Dio().get(urls[i]);
      if (response.statusCode == 200) {
        final result = response.data as Map<String, dynamic>;
        list.add(EpisodeModel.fromJson(result));
      }
    }
    return list;
  }

  void _onReset(EpisodeResetEvet event, Emitter<EpisodeState> emit) {
    emit(const EpisodeReset());
  }
}
