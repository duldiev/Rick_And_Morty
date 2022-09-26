import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/character/models/character.dart';
import 'package:rick_and_morty/enums.dart';

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

class CharacterResetEvet extends CharacterEvent {
  const CharacterResetEvet();

  @override
  List<Object> get props => [];
}

class ResidentFetchEvent extends CharacterEvent {
  final List<String> urls;
  const ResidentFetchEvent({
    required this.urls,
  });

  @override
  List<Object> get props => [urls];
}
