import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rick_and_morty/enums.dart';
import 'package:rick_and_morty/location/bloc/location_state.dart';
import 'package:rick_and_morty/location/bloc/location_event.dart';
import 'package:rick_and_morty/location/models/location.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

// BLOC

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<LocationFetchEvent>(
      _onLocationFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<LocationResetEvet>(
      _onRemoveAll,
    );
  }

  void _onRemoveAll(LocationResetEvet event, Emitter<LocationState> emit) {
    emit(const LocationRemoveAll());
  }

  Future<void> _onLocationFetched(
      LocationFetchEvent event, Emitter<LocationState> emit) async {
    try {
      if (state.hasReachedMax) return;
      if (state.status == LocationStatus.initial) {
        final locations = await _fetchLocation(
          1,
          event.type,
          event.dimension,
        );
        return emit(state.copyWith(
          status: LocationStatus.success,
          locations: locations,
          hasReachedMax: false,
        ));
      }

      final locations = await _fetchLocation(
        state.locations.length ~/ 20 + 1,
        event.type,
        event.dimension,
      );

      emit(locations.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: LocationStatus.success,
              locations: List.of(state.locations)..addAll(locations),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: LocationStatus.failure));
    }
  }

  Future<List<LocationModel>> _fetchLocation([
    int page = 1,
    Type type = Type.any,
    Dimension dimension = Dimension.any,
  ]) async {
    Dio dio = Dio(BaseOptions(
      baseUrl: "https://rickandmortyapi.com/api",
      method: 'GET',
    ));
    final response = await dio.request(
      "/location",
      queryParameters: {
        'page': page,
        'type': type == Type.any ? '' : type.name,
        'dimension': dimension == Dimension.any ? '' : _rename(dimension),
      },
    );
    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return LocationModel.fromJson(map);
      }).toList();
    }
    throw Exception('error fetching locations');
  }

  String _rename(Dimension e) {
    switch (e.name) {
      case "c_137":
        return "C-137";
      case "post_apocalyptic_dimension":
        return "Post-Apocalyptic";
      case "dimension_5_126":
        return "5-126";
      case "fantasy_dimension":
        return "fantasy";
    }
    return e.name;
  }
}
