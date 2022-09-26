// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_event.dart';
import 'package:rick_and_morty/constants.dart';
import 'package:rick_and_morty/filter_cubit.dart';
import 'package:rick_and_morty/enums.dart';
import 'package:rick_and_morty/location/bloc/location_bloc.dart';
import 'package:rick_and_morty/location/bloc/location_event.dart';
import 'package:rick_and_morty/location/bloc/location_state.dart';
import 'package:rick_and_morty/location/widgets/location_detail_page.dart';
import 'package:rick_and_morty/reusable_widgets/location_card.dart';

double filterPosition = Consts.positions.ATTENTION_INVISIBLE;

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

List<Type> typeList = Type.values;
List<Dimension> dimensionList = Dimension.values;

class _LocationViewState extends State<LocationView> {
  final TextEditingController _controller = TextEditingController();

  bool _ingoreBackWidgets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "images/logo.png",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(children: [
        IgnorePointer(
          ignoring: _ingoreBackWidgets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("images/logo2.png"),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding:
                        const EdgeInsets.only(top: 5, bottom: 5, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          flex: 6,
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Filter by name...",
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          filterPosition = Consts.positions.MARKERPILL_VISIBLE;
                          _ingoreBackWidgets = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(0, 50),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.filter_list),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "ADVANCED FILTERS",
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(""),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const LocationListView(),
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          top: filterPosition,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInBack,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset.zero,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 10, left: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Filter",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BlocBuilder<TypeCubit, Type>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              value: state.name,
                              onChanged: (String? value) {
                                List<Type> list = Type.values.toList();
                                for (int i = 0; i < list.length; i++) {
                                  if (list[i].name == value) {
                                    context.read<TypeCubit>().changeTo(list[i]);
                                  }
                                }
                              },
                              items: typeList
                                  .map<DropdownMenuItem<String>>((Type value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BlocBuilder<DimensionCubit, Dimension>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              value: state.name,
                              onChanged: (String? value) {
                                List<Dimension> list =
                                    Dimension.values.toList();
                                for (int i = 0; i < list.length; i++) {
                                  if (list[i].name == value) {
                                    context
                                        .read<DimensionCubit>()
                                        .changeTo(list[i]);
                                  }
                                }
                              },
                              items: dimensionList
                                  .map<DropdownMenuItem<String>>(
                                      (Dimension value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Type typePicked = context.read<TypeCubit>().state;
                        Dimension dimensionPicked =
                            context.read<DimensionCubit>().state;

                        context
                            .read<LocationBloc>()
                            .add(const LocationResetEvet());

                        context.read<LocationBloc>().add(
                              LocationFetchEvent(
                                type: typePicked,
                                dimension: dimensionPicked,
                              ),
                            );
                        setState(() {
                          filterPosition = Consts.positions.ATTENTION_INVISIBLE;
                          _ingoreBackWidgets = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fixedSize: Size(0, 40),
                      ),
                      child: const Text("APPLY"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class LocationListView extends StatelessWidget {
  const LocationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<LocationBloc, LocationState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.status) {
              case LocationStatus.failure:
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 150),
                  child: Text(
                    'Not found',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ));
              case LocationStatus.success:
                if (state.locations.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 150),
                      child: Text(
                        'No locations',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: state.locations.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return LocationCard(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: ((context) => CharacterBloc()
                                    ..add(
                                      ResidentFetchEvent(
                                        urls: state.locations[index].residents,
                                      ),
                                    )),
                                  child: LocationDetailPage(
                                    location: state.locations[index],
                                  ),
                                ),
                              ),
                            );
                          },
                          name: state.locations[index].name,
                          type: state.locations[index].type,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        bottom: 20,
                        left: 100,
                        right: 100,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Type typePicked = context.read<TypeCubit>().state;
                          Dimension dimensionPicked =
                              context.read<DimensionCubit>().state;

                          context.read<LocationBloc>().add(
                                LocationFetchEvent(
                                  type: typePicked,
                                  dimension: dimensionPicked,
                                ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40),
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        child: const Text(
                          "Load more",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              case LocationStatus.initial:
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 150),
                  child: CircularProgressIndicator(),
                ));
            }
          },
        ),
      ],
    );
  }
}
