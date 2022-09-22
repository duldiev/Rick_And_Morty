import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final void Function() onPressed;
  final String name;
  final String type;

  const LocationCard({
    Key? key,
    required this.onPressed,
    required this.name,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ],
            color: Colors.black12,
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                type,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
