import 'package:flutter/material.dart';
import 'package:griet_events_app/profile.dart';

class RightSideIcons extends StatelessWidget {
  const RightSideIcons({
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
                Icons.person,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileSettingScreen()));
              },
            )
          ],
        ),
        const SizedBox(
          width: 15.0,
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}
