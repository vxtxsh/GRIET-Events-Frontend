import 'package:flutter/material.dart';
import 'package:griet_events_app/right_bar.dart';

import 'left_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.orange[100],
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: size.height * .1,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            LeftSideIcons(),
            RightSideIcons(),
          ],
        ),
      ),
    );
  }
}
