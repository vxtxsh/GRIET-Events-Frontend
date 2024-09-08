import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String eventName;
  final Image eventImage;
  final String eventDescription;
  final String eventDate;
  final String eventVenue;
  final String eventTime;

  EventDetailPage({
    required this.eventName,
    required this.eventImage,
    required this.eventDescription,
    required this.eventDate,
    required this.eventVenue,
    required this.eventTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          eventName,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            eventImage,
            const SizedBox(height: 20.0),
            Text(
              eventDescription,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 10.0),
                Text(
                  eventDate,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.grey),
                const SizedBox(width: 10.0),
                Text(
                  eventVenue,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Icon(Icons.access_time, color: Colors.grey),
                const SizedBox(width: 10.0),
                Text(
                  eventTime,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 40, 81, 42),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
