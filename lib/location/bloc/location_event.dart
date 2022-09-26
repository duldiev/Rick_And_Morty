import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/enums.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object> get props => [];
}

class LocationFetchEvent extends LocationEvent {
  final String name;
  final Type type;
  final Dimension dimension;

  const LocationFetchEvent({
    this.name = "",
    this.type = Type.any,
    this.dimension = Dimension.any,
  });

  @override
  List<Object> get props => [type, dimension];
}

class LocationResetEvet extends LocationEvent {
  const LocationResetEvet();

  @override
  List<Object> get props => [];
}
