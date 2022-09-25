// ignore_for_file: depend_on_referenced_packages

import 'package:rick_and_morty/character/enums.dart';
import 'package:bloc/bloc.dart';

class SpeciesCubit extends Cubit<Species> {
  SpeciesCubit() : super(Species.any);

  void changeTo(Species toSpecies) => emit(toSpecies);
}

class GenderCubit extends Cubit<Gender> {
  GenderCubit() : super(Gender.any);

  void changeTo(Gender toGender) => emit(toGender);
}

class StatusCubit extends Cubit<Status> {
  StatusCubit() : super(Status.any);

  void changeTo(Status toStatus) => emit(toStatus);
}
