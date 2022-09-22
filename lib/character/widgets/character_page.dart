// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_bloc.dart';
import 'package:rick_and_morty/character/bloc/character_event.dart';
import 'package:rick_and_morty/character/bloc/character_state.dart';
import 'package:rick_and_morty/character/models/character.dart';
import 'package:rick_and_morty/character/widgets/character_detail_page.dart';
import 'package:rick_and_morty/reusable_widgets/character_card.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

const List<String> speciesList = <String>['Human', 'Two', 'Three', 'Four'];
const List<String> genderList = <String>['Male', 'Two', 'Three', 'Four'];
const List<String> statusList = <String>['Alive', 'Two', 'Three', 'Four'];

class _CharacterPageState extends State<CharacterPage> {
  final TextEditingController _controller = TextEditingController();
  final Key _key = Key("Filter");

  String speciesValue = speciesList.first;
  String genderValue = genderList.first;
  String statusValue = statusList.first;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterBloc()..add(CharacterFetchEvent()),
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
              icon: Icon(Icons.menu),
            )
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("images/logo2.png"),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.only(top: 5, bottom: 5, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Filter by name...",
                            ),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Filters"),
                            content: Stack(
                              children: [
                                Form(
                                  key: _key,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: DropdownButton<String>(
                                          value: speciesValue,
                                          onChanged: (String? value) {
                                            setState(() {
                                              speciesValue = value!;
                                            });
                                          },
                                          items: speciesList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: DropdownButton<String>(
                                          value: genderValue,
                                          onChanged: (String? value) {
                                            setState(() {
                                              genderValue = value!;
                                            });
                                          },
                                          items: genderList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: DropdownButton<String>(
                                          value: statusValue,
                                          onChanged: (String? value) {
                                            setState(() {
                                              statusValue = value!;
                                            });
                                          },
                                          items: statusList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size.fromHeight(40),
                                          backgroundColor: Colors.lightBlue,
                                        ),
                                        child: Text(
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
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(60),
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    child: Row(
                      children: [
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
                CharacterListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterListView extends StatelessWidget {
  CharacterListView({super.key});

  final List<CharacterModel> _characters = [];

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
                  padding: EdgeInsets.only(
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
          visible: context.read<CharacterBloc>().state.hasReachedMax ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 20,
              left: 100,
              right: 100,
            ),
            child: ElevatedButton(
              onPressed: () {
                context.read<CharacterBloc>().add(CharacterFetchEvent());
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromHeight(40),
                backgroundColor: Colors.lightBlueAccent,
              ),
              child: Text(
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
