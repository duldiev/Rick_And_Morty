import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/location/models/location.dart';

enum LocationStatus { initial, success, failure }

class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStatus.initial,
    this.locations = const <LocationModel>[],
    this.hasReachedMax = false,
  });

  final LocationStatus status;
  final List<LocationModel> locations;
  final bool hasReachedMax;

  LocationState copyWith({
    LocationStatus? status,
    List<LocationModel>? locations,
    bool? hasReachedMax,
  }) {
    return LocationState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''LocationState { status: $status, hasReachedMax: $hasReachedMax, locations: ${locations.length} }''';
  }

  @override
  List<Object> get props => [status, locations, hasReachedMax];
}

class LocationRemoveAll extends LocationState {
  const LocationRemoveAll()
      : super(
          status: LocationStatus.initial,
          locations: const <LocationModel>[],
          hasReachedMax: false,
        );

  @override
  List<Object> get props => [status, locations, hasReachedMax];
}
