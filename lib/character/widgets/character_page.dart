import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_event.dart';
import 'package:rick_and_morty/character/bloc/character_state.dart';
import 'package:rick_and_morty/character/bloc/filter_cubit.dart';
import 'package:rick_and_morty/character/widgets/character_detail_page.dart';
import 'package:rick_and_morty/reusable_widgets/character_card.dart';

class CharacterPage extends StatefulWidget {
  final Species species;
  final Gender gender;
  final Status status;

  CharacterPage({
    super.key,
    this.species = Species.any,
    this.gender = Gender.any,
    this.status = Status.any,
  });

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final TextEditingController _controller = TextEditingController();

  final Key _key = const Key("Filter");
  bool _filterVisible = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(create: (context) => CharacterBloc()..add(const CharacterFetchEvent())),
        BlocProvider<SpeciesCubit>(create: (context) => SpeciesCubit()),
        BlocProvider<GenderCubit>(create: (context) => GenderCubit()),
        BlocProvider<StatusCubit>(create: (context) => StatusCubit()),
      ],
      child: Scaffold(
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
            SingleChildScrollView(
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
                      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 20),
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
                            child: Container(
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
                            _filterVisible = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(60),
                          backgroundColor: Colors.lightBlueAccent,
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
            Visibility(
              visible: _filterVisible,
              child: AlertDialog(
                title: const Text("Filters"),
                content: Stack(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child: BlocBuilder<SpeciesCubit,
                                Species>(
                              builder: (context, state) {
                                return DropdownButton<String>(
                                  value: state.name,
                                  onChanged: (String? value) {
                                    List<Species> list =
                                    Species.values.toList();
                                    for (int i = 0;
                                    i < list.length;
                                    i++) {
                                      if (list[i].name == value) {
                                        context
                                            .read<SpeciesCubit>()
                                            .changeTo(list[i]);
                                      }
                                    }
                                  },
                                  items: speciesList.map<
                                      DropdownMenuItem<
                                          String>>(
                                          (Species value) {
                                        return DropdownMenuItem<
                                            String>(
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
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child:
                            BlocBuilder<GenderCubit, Gender>(
                              builder: (context, state) {
                                return DropdownButton<String>(
                                  value: state.name,
                                  onChanged: (String? value) {
                                    List<Gender> list =
                                    Gender.values.toList();
                                    for (int i = 0;
                                    i < list.length;
                                    i++) {
                                      if (list[i].name == value) {
                                        context
                                            .read<GenderCubit>()
                                            .changeTo(list[i]);
                                      }
                                    }
                                  },
                                  items: genderList.map<
                                      DropdownMenuItem<
                                          String>>(
                                          (Gender value) {
                                        return DropdownMenuItem<
                                            String>(
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
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child:
                            BlocBuilder<StatusCubit, Status>(
                              builder: (context, state) {
                                return DropdownButton<String>(
                                  value: state.name,
                                  onChanged: (String? value) {
                                    List<Status> list =
                                    Status.values.toList();
                                    for (int i = 0;
                                    i < list.length;
                                    i++) {
                                      if (list[i].name == value) {
                                        context
                                            .read<StatusCubit>()
                                            .changeTo(list[i]);
                                      }
                                    }
                                  },
                                  items: statusList.map<
                                      DropdownMenuItem<
                                          String>>(
                                          (Status value) {
                                        return DropdownMenuItem<
                                            String>(
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
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _filterVisible = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CharacterPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize:
                              const Size.fromHeight(40),
                              backgroundColor: Colors.lightBlue,
                            ),
                            child: const Text(
                              "APPLY",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]
        ),
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
                return const Center(child: Text('failed to fetch characters'));
              case CharacterStatus.success:
                if (state.characters.isEmpty) {
                  return const Center(child: Text('no characters'));
                }
                return ListView.builder(
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
                            builder: (context) => CharacterDetailPage(
                              character: state.characters[index],
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
                );
              case CharacterStatus.initial:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Visibility(
          visible:
              context.read<CharacterBloc>().state.hasReachedMax ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 20,
              left: 100,
              right: 100,
            ),
            child: ElevatedButton(
              onPressed: () {
                context.read<CharacterBloc>().add(const CharacterFetchEvent());
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
        ),
      ],
    );
  }
}
