import 'package:flutter/material.dart';
import 'package:griet_events_app/additives/bottom_bar.dart';
import 'package:griet_events_app/event_display.dart';
import 'package:griet_events_app/additives/floating_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

import 'add_event.dart';
import 'additives/management_page.dart';

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

  EventModel(
      {required this.eventId,
      required this.name,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.venue,
      required this.description,
      required this.type,
      required this.contact,
      required this.club,
      required this.image});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['eventId'],
      name: json['name'],
      date: _parseDate(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      venue: VenueModel.fromJson(json['venue']),
      description: json['description'],
      type: EventTypeModel.fromJson(json['type']),
      contact: ContactModel.fromJson(json['contact']),
      club: ClubModel.fromJson(json['club']),
      image: json['image'],
    );
  }

  static String _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      final formattedDate =
          '${parts[2]}-${parts[0].padLeft(2, '0')}-${parts[1].padLeft(2, '0')}';
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

class EventService {
  final String baseUrl = 'http://IP Address:8080';

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events/'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<EventModel>((event) => EventModel.fromJson(event))
          .toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<EventModel>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = EventService().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MyFloatingActionButton(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/griet_logo.png'),
        ),
        title: Text(
          "GRIET EVENTS",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.notifications,
          //     color: Colors.black,
          //   ),
          // ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/aac_logo.png'),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 20),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/person.jpg'),
                ),
                SizedBox(width: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Hey user !',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Let's get you started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(height: 20),
            FutureBuilder<List<EventModel>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load events'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No events available'));
                } else {
                  List<EventModel> ongoingEvents = snapshot.data!
                      .where((event) => eventIsOngoing(event, currentDate))
                      .toList();
                  return EventSection(
                    title: 'Ongoing events',
                    events: ongoingEvents,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<List<EventModel>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load events'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No events available'));
                } else {
                  List<EventModel> upcomingEvents = snapshot.data!
                      .where((event) => eventIsUpcoming(event, currentDate))
                      .toList();
                  return EventSection(
                    title: 'Upcoming events',
                    events: upcomingEvents,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              '  Search By Category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  RoundedBoxWithText(
                    text: 'Technical',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            category: 'technical',
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  RoundedBoxWithText(
                    text: 'Cultural',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            category: 'cultural',
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  RoundedBoxWithText(
                    text: 'Non-Technical',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            category: 'nonTechnical',
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  RoundedBoxWithText(
                    text: 'Technical and Non-Technical',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            category: 'technicalandnontechnical',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool eventIsUpcoming(EventModel event, DateTime currentDate) {
    DateTime eventDate = event.getDateTime();
    return eventDate.isAfter(currentDate);
  }

  bool eventIsOngoing(EventModel event, DateTime currentDate) {
    DateTime eventDate = event.getDateTime();
    DateTime eventEndDate = eventDate.add(Duration(hours: 24));
    return eventDate.isBefore(currentDate) && eventEndDate.isAfter(currentDate);
  }

//bool eventIsOngoing(EventModel event, DateTime currentDate) {
//     DateTime eventDate = event.getDateTime();
//     return eventDate.isAtSameMomentAs(currentDate) ||
//         eventDate.isBefore(currentDate);
//   }

//   bool eventIsUpcoming(EventModel event, DateTime currentDate) {
//     DateTime eventDate = event.getDateTime();
//     return eventDate.isAfter(currentDate);
//   }
}

class EventSection extends StatelessWidget {
  final String title;
  final List<EventModel> events;

  EventSection({required this.title, required this.events});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Color.fromARGB(255, 231, 228, 228),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: events[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventModel event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              eventName: event.name,
              eventImage: event.image != null
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
              eventDescription: event.description,
              eventDate: event.date,
              eventVenue: event.venue.venueName,
              eventTime: '${event.startTime} - ${event.endTime}',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 239, 238, 238),
                offset: Offset(-5.0, -5.0),
                blurRadius: 5,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 212, 212, 212),
                offset: Offset(7.0, 7.0),
                blurRadius: 17,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      event.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(event.venue.venueName),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('${event.startTime} - ${event.endTime}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(event.date),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedBoxWithText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const RoundedBoxWithText({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String category;

  CategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$category Events'),
        backgroundColor: Colors.orange[100],
      ),
      body: FutureBuilder<List<EventModel>>(
        future: EventService().fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load events'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events available'));
          } else {
            List<EventModel> filteredEvents = snapshot.data!
                .where((event) =>
                    event.type.name.toLowerCase() == category.toLowerCase())
                .toList();
            return EventSection(
              title: '$category events',
              events: filteredEvents,
            );
          }
        },
      ),
    );
  }
}


     