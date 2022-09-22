import 'package:dio/dio.dart';

class LocationRepository {
  static final LocationRepository _beerRepository = LocationRepository._();

  LocationRepository._();

  factory LocationRepository() {
    return _beerRepository;
  }

  Future<dynamic> getLocations({required int page}) async {}
}
