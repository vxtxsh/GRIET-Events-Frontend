import 'package:flutter/material.dart';
import 'package:griet_events_app/add_event.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            elevation: 5.0,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateEventPage()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            ),
            shape: CircleBorder(eccentricity: BorderSide.strokeAlignCenter),
          ),
        ),
      ),
    );
  }
}
