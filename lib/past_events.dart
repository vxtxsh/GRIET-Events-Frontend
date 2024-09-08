import 'package:flutter/material.dart';
import 'package:griet_events_app/upcoming_events.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EventModel {
  final int eventId;
  final String name;
  final String date;
  final String startTime;
  final String endTime;
  final VenueModel venue;
  final String description;
  final EventTypeModel type;
  final ContactModel contact;
  final ClubModel club;
  final String? image;

  EventModel({
    required this.eventId,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.description,
    required this.type,
    required this.contact,
    required this.club,
    required this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['eventId'],
      name: json['name'] ?? '',
      date: _parseDate(json['date'] ?? ''),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      venue: VenueModel.fromJson(json['venue']),
      description: json['description'] ?? '',
      type: EventTypeModel.fromJson(json['type']),
      contact: ContactModel.fromJson(json['contact']),
      club: ClubModel.fromJson(json['club']),
      image: json['image'],
    );
  }

  static String _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length != 3) {
        throw FormatException('Invalid date format: $dateStr');
      }
      final formattedDate =
          '${parts[2]}-${parts[0].padLeft(2, '0')}-${parts[1].padLeft(2, '0')}';
      // Validate the formatted date
      final parsedDate = DateTime.tryParse(formattedDate);
      if (parsedDate == null) {
        throw FormatException('Invalid formatted date: $formattedDate');
      }
      return formattedDate;
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  DateTime getDateTime() {
    try {
      return DateTime.parse(date);
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now();
    }
  }
}

class VenueModel {
  final int venueId;
  final String venueName;

  VenueModel({required this.venueId, required this.venueName});

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      venueId: json['venueId'],
      venueName: json['venueName'],
    );
  }
}

class EventTypeModel {
  final int contactId;
  final String name;
  final String email;
  final String phone;

  EventTypeModel(
      {required this.contactId,
      required this.name,
      required this.email,
      required this.phone});

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      contactId: json['contactId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class ContactModel {
  final int contactId;
  final String name;
  final String email;
  final String phone;

  ContactModel(
      {required this.contactId,
      required this.name,
      required this.email,
      required this.phone});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      contactId: json['contactId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class ClubModel {
  final int clubId;
  final String clubName;
  final String clubDescription;
  final String clubContact;

  ClubModel(
      {required this.clubId,
      required this.clubName,
      required this.clubDescription,
      required this.clubContact});

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubDescription: json['clubDescription'],
      clubContact: json['clubContact'],
    );
  }
}

class ApiService {
  final String baseUrl = 'http://IP Address:8080';

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<EventModel>((event) => EventModel.fromJson(event))
          .toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}

class EventsPast extends StatefulWidget {
  @override
  _EventsPastState createState() => _EventsPastState();
}

class _EventsPastState extends State<EventsPast> {
  late Future<List<EventModel>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = ApiService().fetchEvents();
  }

  List<EventModel> filterPastEvents(List<EventModel> events) {
    final currentDate = DateTime.now();
    return events.where((event) {
      try {
        final eventDate = DateTime.parse(event.date);
        return eventDate.isBefore(currentDate);
      } catch (e) {
        print('Error parsing date for event: ${event.name}');
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Events'),
        backgroundColor: Colors.orange[100],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       CategoryButton(text: 'Technical Events'),
                //       CategoryButton(text: 'Cultural Events'),
                //       CategoryButton(text: 'Hackathons'),
                //       CategoryButton(text: 'Sports'),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventsUpcoming()),
                        );
                      },
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Text(
                      'Past',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<EventModel>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No past events.'));
                } else {
                  final pastEvents = filterPastEvents(snapshot.data!);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: pastEvents.length,
                      itemBuilder: (context, index) {
                        final event = pastEvents[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: event.image != null
                                        ? Image.memory(
                                            base64Decode(event.image!),
                                            height: 125,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/TECHNICAL.png',
                                            height: 125,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  event.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text('Date: ${event.date}'),
                                Text('Venue: ${event.venue.venueName}'),
                                Text(
                                    'Time: ${event.startTime} - ${event.endTime}'),
                                Text(event.type.name),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;

  const CategoryButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
