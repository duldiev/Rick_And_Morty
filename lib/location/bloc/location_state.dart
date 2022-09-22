import 'package:rick_and_morty/location/models/location.dart';

abstract class LocationState {
  const LocationState();
}

class LocationInitialState extends LocationState {
  const LocationInitialState();
}

class LocationLoadingState extends LocationState {
  final String message;

  const LocationLoadingState({
    required this.message,
  });
}

class LocationSuccessState extends LocationState {
  final List<LocationResponse> beers;

  const LocationSuccessState({
    required this.beers,
  });
}

class LocationErrorState extends LocationState {
  final String error;

  const LocationErrorState({
    required this.error,
  });
}
