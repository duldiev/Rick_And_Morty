// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rick_and_morty/reusable_widgets/character_card.dart';

class LocationDetailPage extends StatefulWidget {
  final String title;
  const LocationDetailPage({super.key, required this.title});

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
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
              Container(
                padding: EdgeInsets.only(right: 280),
                child: MaterialButton(
                  onPressed: () {

                  },
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 10,),
                      Text("GO BACK"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Planet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dimension",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Replacement",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Dimension",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                "Residents",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CharacterCard(onPressed: () {}, image: Image.asset("images/rick_image.png", fit: BoxFit.cover,), name: "Rick", species: "Human"),
                  CharacterCard(onPressed: () {}, image: Image.asset("images/rick_image.png", fit: BoxFit.cover,), name: "Rick", species: "Human"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}