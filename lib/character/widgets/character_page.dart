// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_event.dart';
import 'package:rick_and_morty/filter_cubit.dart';
import 'package:rick_and_morty/character/widgets/character_view.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SpeciesCubit>(create: (_) => SpeciesCubit()),
        BlocProvider<GenderCubit>(create: (_) => GenderCubit()),
        BlocProvider<StatusCubit>(create: (_) => StatusCubit()),
        BlocProvider<CharacterBloc>(
            create: (_) => CharacterBloc()
              ..add(CharacterResetEvet())
              ..add(const CharacterFetchEvent())),
      ],
      child: CharacterView(),
    );
  }
}
