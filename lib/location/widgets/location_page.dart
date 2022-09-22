import 'package:flutter/material.dart';
import 'package:rick_and_morty/reusable_widgets/location_card.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

const List<String> typeList = <String>['Type', 'Two', 'Three', 'Four'];
const List<String> dimensionList = <String>[
  'Dimension',
  'Two',
  'Three',
  'Four'
];

class _LocationPageState extends State<LocationPage> {
  late TextEditingController _controller;
  late Key _key;

  String typeValue = typeList.first;
  String dimensionValue = dimensionList.first;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _key = const Key("Filter");
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
              Image.asset("images/logo3.png"),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButton<String>(
                                        value: typeValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            typeValue = value!;
                                          });
                                        },
                                        items: typeList
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButton<String>(
                                        value: dimensionValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            dimensionValue = value!;
                                          });
                                        },
                                        items: dimensionList
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
              ListView.builder(
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return LocationCard(
                    onPressed: () {},
                    name: "Earth",
                    type: "Planet",
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
                  onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
