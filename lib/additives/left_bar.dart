import 'package:flutter/material.dart';
import 'package:griet_events_app/management_page.dart';
import 'package:griet_events_app/upcoming_events.dart';

class LeftSideIcons extends StatelessWidget {
  const LeftSideIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.school,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GoverningBodyScreen()));
              },
            ),
          ],
        ),
        const SizedBox(
          width: 15.0,
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.event,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventsUpcoming()));
              },
            )
          ],
        ),
      ],
    );
  }
}
