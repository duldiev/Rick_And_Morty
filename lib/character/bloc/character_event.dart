import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
  @override
  List<Object> get props => [];
}

enum Species { any, human, alien, humanoid, poopybutthole, cronenberg, animal }

enum Gender { any, male, female, genderless, unknown }

enum Status { any, alive, dead, unknown }

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
