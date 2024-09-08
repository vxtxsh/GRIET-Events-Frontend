// import 'package:flutter/material.dart';
// import 'package:griet_event/main.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class CreateEventPage extends StatefulWidget {
//   const CreateEventPage({Key? key}) : super(key: key);

//   @override
//   _CreateEventPageState createState() => _CreateEventPageState();
// }

// enum VenueType {
//   hall1,
//   hall2,
//   itblock,
//   aiml,
//   block,
//   cseblock,
//   ground,
//   busparking,
//   bikeparking,
//   carparking,
//   pharmacy,
//   lailawati
// }

// extension VenueTypeExtension on VenueType {
//   String get name {
//     switch (this) {
//       case VenueType.hall1:
//         return 'hall1';
//       case VenueType.hall2:
//         return 'hall2';
//       case VenueType.itblock:
//         return 'itblock';
//       case VenueType.aiml:
//         return 'aimlBlock';
//       case VenueType.cseblock:
//         return 'cseblock';
//       case VenueType.ground:
//         return 'ground';
//       case VenueType.busparking:
//         return 'busParking';
//       case VenueType.bikeparking:
//         return 'bikeParking';
//       case VenueType.carparking:
//         return 'carParking';
//       case VenueType.pharmacy:
//         return 'pharmacy';
//       case VenueType.lailawati:
//         return 'lailawati';
//       default:
//         return '';
//     }
//   }
// }

// enum EventType { technical, nonTechnical, technicalandnontechnical, cultural }

// extension EventTypeExtension on EventType {
//   String get type {
//     switch (this) {
//       case EventType.technical:
//         return 'technical';
//       case EventType.nonTechnical:
//         return 'nontechnical';
//       case EventType.cultural:
//         return 'cultural';
//       case EventType.technicalandnontechnical:
//         return 'technicalandnontechnical';
//       default:
//         return '';
//     }
//   }
// }

// class _CreateEventPageState extends State<CreateEventPage> {
//   final TextEditingController _eventNameController = TextEditingController();
//   final TextEditingController _eventDateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   Future<void> _submitEvent() async {
//     final url = Uri.parse('http://192.168.29.251:8080/events/create');
//     // Prepare event data
//     final eventData = {
//       'eventId': 0,
//       'name': _eventNameController.text,
//       'date': _eventDateController.text,
//       'startTime': _timeController.text,
//       'endTime': _timeController.text,
//       'venue': {'venueId': 0, 'venueName': _selectedVenueType.name},
//       'description': _descriptionController.text,
//       'type': {
//         'typeId': 0,
//         'name': _selectedEventType.type,
//         'email': "string",
//         'phone': "string"
//       },
//       'contact': {
//         'contactId': 1,
//         'name': "string",
//         'email': "string",
//         'phone': "string"
//       },
//       'clubId': 1,
//     };

//     // Send POST request
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(eventData),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Event created successfully
//         print('Event created successfully');

//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => HomeScreen()));
//       } else {
//         // Error creating event
//         print('Failed to create event. Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (error) {
//       // Handle error
//       print('Error creating event: $error');
//     }
//   }

//   final ImagePicker _picker = ImagePicker();

//   Widget? _selectedMediaWidget;
//   EventType _selectedEventType = EventType.technical;
//   VenueType _selectedVenueType = VenueType.hall1;

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now())
//       setState(() {
//         _eventDateController.text = DateFormat.yMd().format(picked);
//       });
//   }

//   Future<void> _pickMedia(BuildContext context) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Media'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 GestureDetector(
//                   child: const Text('Take a Photo'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _pickImage(ImageSource.camera, 'photo');
//                   },
//                 ),
//                 const SizedBox(height: 20.0),
//                 GestureDetector(
//                   child: const Text('Record a Video'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _pickImage(ImageSource.camera, 'video');
//                   },
//                 ),
//                 const SizedBox(height: 20.0),
//                 GestureDetector(
//                   child: const Text('Pick Media from Gallery'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _pickImage(ImageSource.gallery, 'both');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _pickImage(ImageSource source, String mediaType) async {
//     if (mediaType == 'photo' || mediaType == 'video') {
//       final pickedImage = await _picker.pickImage(source: source);
//       if (pickedImage != null) {
//         setState(() {
//           _selectedMediaWidget = Image.file(File(pickedImage.path));
//         });
//       }
//     } else if (mediaType == 'both') {
//       final pickedImage = await _picker.pickImage(source: source);
//       if (pickedImage != null) {
//         setState(() {
//           _selectedMediaWidget = Image.file(File(pickedImage.path));
//         });
//       } else {
//         final pickedVideo = await _picker.pickVideo(source: source);
//         if (pickedVideo != null) {
//           setState(() {
//             _selectedMediaWidget = Text('Video Selected: ${pickedVideo.path}');
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Create Event',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.orange[100],
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextField(
//               controller: _eventNameController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Event Name',
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             TextField(
//               controller: _eventDateController,
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 hintText: 'Event Date',
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.calendar_today),
//                   onPressed: () {
//                     _selectDate(context);
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             const Text(
//               'Select Venue:',
//               style: TextStyle(color: Colors.grey),
//             ),
//             DropdownButton<VenueType>(
//               value: _selectedVenueType,
//               onChanged: (VenueType? value) {
//                 if (value != null) {
//                   setState(() {
//                     _selectedVenueType = value;
//                   });
//                 }
//               },
//               items: <DropdownMenuItem<VenueType>>[
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.hall1,
//                   child: Text('Hall1'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.hall2,
//                   child: Text('Hall2'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.itblock,
//                   child: Text('IT Block'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.aiml,
//                   child: Text('AIML Block'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.cseblock,
//                   child: Text('CSE Block'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.ground,
//                   child: Text('Ground'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.busparking,
//                   child: Text('Bus Parking'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.bikeparking,
//                   child: Text('Bike Parking'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.carparking,
//                   child: Text('Car Parking'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.pharmacy,
//                   child: Text('Pharmacy'),
//                 ),
//                 DropdownMenuItem<VenueType>(
//                   value: VenueType.lailawati,
//                   child: Text('Lailawati'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10.0),
//             TextField(
//               controller: _timeController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Time',
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             TextField(
//               controller: _descriptionController,
//               maxLines: null,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Event Description',
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             const Text(
//               'Select Event Type:',
//               style: TextStyle(color: Colors.grey),
//             ),
//             DropdownButton<EventType>(
//               value: _selectedEventType,
//               onChanged: (EventType? value) {
//                 if (value != null) {
//                   setState(() {
//                     _selectedEventType = value;
//                   });
//                 }
//               },
//               items: <DropdownMenuItem<EventType>>[
//                 DropdownMenuItem<EventType>(
//                   value: EventType.technical,
//                   child: Text('Technical'),
//                 ),
//                 DropdownMenuItem<EventType>(
//                   value: EventType.nonTechnical,
//                   child: Text('Non-Technical'),
//                 ),
//                 DropdownMenuItem<EventType>(
//                   value: EventType.technicalandnontechnical,
//                   child: Text('Technical and Non-Technical'),
//                 ),
//                 DropdownMenuItem<EventType>(
//                   value: EventType.cultural,
//                   child: Text('Cultural'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10.0),
//             /*const Text(
//               'Upload Media',
//               style: TextStyle(color: Colors.grey),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.85,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.camera_alt),
//                     onPressed: () {
//                       _pickMedia(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),*/
//             const SizedBox(height: 20.0),
//             _selectedMediaWidget ?? Container(),
//             const SizedBox(height: 20.0),
//             Container(
//               height: 60.0,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _submitEvent,
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       Color.fromARGB(255, 40, 81, 42)),
//                   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                     const EdgeInsets.symmetric(vertical: 15.0),
//                   ),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(fontSize: 20.0, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:griet_events_app/main.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert'; // Import for base64Encode
import 'package:http/http.dart' as http;

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

enum VenueType {
  hall1,
  hall2,
  itblock,
  aiml,
  block,
  cseblock,
  ground,
  busparking,
  bikeparking,
  carparking,
  pharmacy,
  lailawati
}

extension VenueTypeExtension on VenueType {
  String get name {
    switch (this) {
      case VenueType.hall1:
        return 'hall1';
      case VenueType.hall2:
        return 'hall2';
      case VenueType.itblock:
        return 'itblock';
      case VenueType.aiml:
        return 'aimlBlock';
      case VenueType.cseblock:
        return 'cseblock';
      case VenueType.ground:
        return 'ground';
      case VenueType.busparking:
        return 'busParking';
      case VenueType.bikeparking:
        return 'bikeParking';
      case VenueType.carparking:
        return 'carParking';
      case VenueType.pharmacy:
        return 'pharmacy';
      case VenueType.lailawati:
        return 'lailawati';
      default:
        return '';
    }
  }
}

enum EventType { technical, nonTechnical, technicalandnontechnical, cultural }

extension EventTypeExtension on EventType {
  String get type {
    switch (this) {
      case EventType.technical:
        return 'technical';
      case EventType.nonTechnical:
        return 'nontechnical';
      case EventType.cultural:
        return 'cultural';
      case EventType.technicalandnontechnical:
        return 'technicalandnontechnical';
      default:
        return '';
    }
  }
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Widget? _selectedMediaWidget;
  EventType _selectedEventType = EventType.technical;
  VenueType _selectedVenueType = VenueType.hall1;

  Future<void> _submitEvent() async {
    final url = Uri.parse('http://IP address:8080/events/create');

    String? base64Image;
    if (_selectedMediaWidget != null) {
      final file = (_selectedMediaWidget as Image).image;
      final fileImage = file as FileImage;
      final imageFile = File(fileImage.file.path);
      base64Image = base64Encode(await imageFile.readAsBytes());
    }

    final eventData = {
      'eventId': 0,
      'name': _eventNameController.text,
      'date': _eventDateController.text,
      'startTime': _timeController.text,
      'endTime': _timeController.text,
      'venue': {'venueId': 0, 'venueName': _selectedVenueType.name},
      'description': _descriptionController.text,
      'type': {
        'typeId': 0,
        'name': _selectedEventType.type,
        'email': "string",
        'phone': "string"
      },
      'contact': {
        'contactId': 1,
        'name': "string",
        'email': "string",
        'phone': "string"
      },
      'clubId': 1,
      'image': base64Image // Add base64 image data here
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(eventData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Event created successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print('Failed to create event. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error creating event: $error');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedMediaWidget = Image.file(File(pickedImage.path));
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101), 
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _eventDateController.text = DateFormat.yMd().format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Event',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            TextField(
                controller: _eventNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Event Name')),
            const SizedBox(height: 10.0),
            TextField(
              controller: _eventDateController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Event Date',
                suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context)),
              ),
            ),
            const SizedBox(height: 10.0),
            DropdownButton<VenueType>(
              value: _selectedVenueType,
              onChanged: (VenueType? value) {
                if (value != null) setState(() => _selectedVenueType = value);
              },
              items: VenueType.values.map((VenueType venueType) {
                return DropdownMenuItem<VenueType>(
                  value: venueType,
                  child: Text(venueType.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Time')),
            const SizedBox(height: 10.0),
            TextField(
                controller: _descriptionController,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Event Description')),
            const SizedBox(height: 10.0),
            DropdownButton<EventType>(
              value: _selectedEventType,
              onChanged: (EventType? value) {
                if (value != null) setState(() => _selectedEventType = value);
              },
              items: EventType.values.map((EventType eventType) {
                return DropdownMenuItem<EventType>(
                  value: eventType,
                  child: Text(eventType.type),
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            const Text('Upload Media', style: TextStyle(color: Colors.grey)),
            IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () => _pickImage(ImageSource.gallery)),
            const SizedBox(height: 20.0),
            _selectedMediaWidget ?? Container(),
            const SizedBox(height: 20.0),
            Container(
              height: 60.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitEvent,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 40, 81, 42)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 15.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                child: const Text('Submit',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
