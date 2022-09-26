// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/widgets/character_view.dart';
import 'package:rick_and_morty/filter_cubit.dart';
import 'package:rick_and_morty/location/bloc/location_bloc.dart';
import 'package:rick_and_morty/location/bloc/location_event.dart';
import 'package:rick_and_morty/location/widgets/location_view.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TypeCubit>(create: (_) => TypeCubit()),
        BlocProvider<DimensionCubit>(create: (_) => DimensionCubit()),
        BlocProvider<LocationBloc>(
            create: (_) => LocationBloc()..add(const LocationFetchEvent())),
      ],
      child: LocationView(),
    );
  }
}
