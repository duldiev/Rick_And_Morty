import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/character/enums.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
  @override
  List<Object> get props => [];
}

class CharacterFetchEvent extends CharacterEvent {
  final Species species;
  final Gender gender;
  final Status status;

  const CharacterFetchEvent({
    this.species = Species.any,
    this.gender = Gender.any,
    this.status = Status.any,
  });

  @override
  List<Object> get props => [species, gender, status];
}
