// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character/bloc/episode/episode_bloc.dart';
import 'package:rick_and_morty/character/bloc/episode/episode_state.dart';
import 'package:rick_and_morty/character/models/character.dart';
import 'package:rick_and_morty/reusable_widgets/info_card.dart';
import 'package:rick_and_morty/reusable_widgets/episode_card.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailPage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "images/logo.png",
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
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    SizedBox(
                      width: 10,
                    ),
                    Text("GO BACK"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ClipOval(
                  child: Image(
                    image: NetworkImage(
                      character.image,
                    ),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  character.name,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Information",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      title: "Gender",
                      info: character.gender,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    InfoCard(
                      title: "Status",
                      info: character.status,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    InfoCard(
                      title: "Specie",
                      info: character.species,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    InfoCard(
                      title: "Origin",
                      info: character.origin.name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    InfoCard(
                      title: "Type",
                      info: character.type,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    InfoCard(
                      title: "Location",
                      info: character.location.name,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Episodes",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: BlocBuilder<EpisodeBloc, EpisodeState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case EpisodeStatus.initial:
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 120, bottom: 150),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case EpisodeStatus.failure:
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 120, bottom: 150),
                            child: Text(
                              'Not Found',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                        );
                      case EpisodeStatus.success:
                        if (state.episodes.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 120, bottom: 150),
                              child: Text(
                                'No Episodes',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: character.episode.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                EpisodeCard(
                                  onTap: () {},
                                  number: state.episodes[index].episode,
                                  title: state.episodes[index].name,
                                  releaseDate: state.episodes[index].airDate,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
