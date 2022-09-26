// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:rick_and_morty/character/bloc/character_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_event.dart';
import 'package:rick_and_morty/character/bloc/character_state.dart';
import 'package:rick_and_morty/character/bloc/episode/episode_bloc.dart';
import 'package:rick_and_morty/character/bloc/episode/episode_event.dart';
import 'package:rick_and_morty/character/widgets/character_detail_page.dart';
import 'package:rick_and_morty/constants.dart';
import 'package:rick_and_morty/enums.dart';
import 'package:rick_and_morty/filter_cubit.dart';
import 'package:rick_and_morty/reusable_widgets/character_card.dart';

double filterPosition = Consts.positions.ATTENTION_INVISIBLE;

class CharacterView extends StatefulWidget {
  const CharacterView({super.key});

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {
  final TextEditingController _controller = TextEditingController();
  bool _ingoreBackWidgets = false;

  @override
  void initState() {
    super.initState();
  }

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
      body: Stack(
        children: [
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
                            child: BlocBuilder<CharacterBloc, CharacterState>(
                              builder: (context, state) {
                                return TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Filter by name...",
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  onChanged: (value) {
                                    context
                                        .read<CharacterBloc>()
                                        .add(CharacterResetEvet());
                                    context
                                        .read<CharacterBloc>()
                                        .add(CharacterFetchEvent(name: value));
                                  },
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            filterPosition =
                                Consts.positions.MARKERPILL_VISIBLE;
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
                    const CharacterListView(),
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
                    padding:
                        const EdgeInsets.only(bottom: 20, top: 10, left: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Filter",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                          child: BlocBuilder<SpeciesCubit, Species>(
                            builder: (context, state) {
                              return DropdownButton<String>(
                                value: state.name,
                                onChanged: (String? value) {
                                  List<Species> list = Species.values.toList();
                                  for (int i = 0; i < list.length; i++) {
                                    if (list[i].name == value) {
                                      context
                                          .read<SpeciesCubit>()
                                          .changeTo(list[i]);
                                    }
                                  }
                                },
                                items: speciesList
                                    .map<DropdownMenuItem<String>>(
                                        (Species value) {
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
                          child: BlocBuilder<GenderCubit, Gender>(
                            builder: (context, state) {
                              return DropdownButton<String>(
                                value: state.name,
                                onChanged: (String? value) {
                                  List<Gender> list = Gender.values.toList();
                                  for (int i = 0; i < list.length; i++) {
                                    if (list[i].name == value) {
                                      context
                                          .read<GenderCubit>()
                                          .changeTo(list[i]);
                                    }
                                  }
                                },
                                items: genderList.map<DropdownMenuItem<String>>(
                                    (Gender value) {
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
                          child: BlocBuilder<StatusCubit, Status>(
                            builder: (context, state) {
                              return DropdownButton<String>(
                                value: state.name,
                                onChanged: (String? value) {
                                  List<Status> list = Status.values.toList();
                                  for (int i = 0; i < list.length; i++) {
                                    if (list[i].name == value) {
                                      context
                                          .read<StatusCubit>()
                                          .changeTo(list[i]);
                                    }
                                  }
                                },
                                items: statusList.map<DropdownMenuItem<String>>(
                                    (Status value) {
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
                          Species speciesPicked =
                              context.read<SpeciesCubit>().state;
                          Gender genderPicked =
                              context.read<GenderCubit>().state;
                          Status statusPicked =
                              context.read<StatusCubit>().state;

                          context
                              .read<CharacterBloc>()
                              .add(const CharacterResetEvet());

                          context.read<CharacterBloc>().add(
                                CharacterFetchEvent(
                                  species: speciesPicked,
                                  gender: genderPicked,
                                  status: statusPicked,
                                ),
                              );
                          setState(() {
                            filterPosition =
                                Consts.positions.ATTENTION_INVISIBLE;
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
        ],
      ),
    );
  }
}

List<Species> speciesList = Species.values;
List<Gender> genderList = Gender.values;
List<Status> statusList = Status.values;

class CharacterListView extends StatelessWidget {
  const CharacterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<CharacterBloc, CharacterState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.status) {
              case CharacterStatus.failure:
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 120, bottom: 150),
                    child: Text(
                      'Not Found',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                );
              case CharacterStatus.success:
                if (state.characters.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 120, bottom: 150),
                      child: Text(
                        'No Characters',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: state.characters.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CharacterCard(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: ((context) => EpisodeBloc()
                                    ..add(
                                      EpisodeFetchEvent(
                                        urls: state.characters[index].episode,
                                      ),
                                    )),
                                  child: CharacterDetailPage(
                                    character: state.characters[index],
                                  ),
                                ),
                              ),
                            );
                          },
                          image: Image(
                            image: NetworkImage(
                              state.characters[index].image,
                            ),
                            fit: BoxFit.cover,
                          ),
                          name: state.characters[index].name,
                          species: state.characters[index].species,
                        );
                      },
                    ),
                    if (state.hasReachedMax) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          bottom: 20,
                          left: 100,
                          right: 100,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Species speciesPicked =
                                context.read<SpeciesCubit>().state;
                            Gender genderPicked =
                                context.read<GenderCubit>().state;
                            Status statusPicked =
                                context.read<StatusCubit>().state;

                            context.read<CharacterBloc>().add(
                                  CharacterFetchEvent(
                                    species: speciesPicked,
                                    gender: genderPicked,
                                    status: statusPicked,
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
                  ],
                );
              case CharacterStatus.initial:
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 120, bottom: 150),
                    child: CircularProgressIndicator(),
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
