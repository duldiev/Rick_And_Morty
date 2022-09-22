// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rick_and_morty/character/widgets/character_page.dart';
import 'package:rick_and_morty/location/widgets/location_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            icon: Icon(Icons.add),
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CharacterPage()));
                },
                style: TextButton.styleFrom(
                  fixedSize: Size.fromHeight(60),
                ),
                child: Text(
                  "Characters",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LocationPage()));
                },
                style: TextButton.styleFrom(
                  fixedSize: Size.fromHeight(60),
                ),
                child: Text(
                  "Locations",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
