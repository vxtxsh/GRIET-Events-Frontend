import 'package:flutter/material.dart';

class GoverningBodyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Governing Body'),
        backgroundColor: Colors.orange[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMemberSection(
              title: 'Chairperson',
              name: 'Dr. G. Ganga Raju',
              description:
                  'B.Pharma., Ph.D. Eminent Industrialist Chairman, Laila Group of Companies, Vijayawada',
              image: 'assets/chairperson.jpg',
            ),
            _buildMemberSection(
              title: 'Director',
              name: 'Dr. Jandhyala N Murthy',
              description:
                  'Professor Department of Mechanical Engineering GRIET, Hyderabad.',
              image: 'assets/director.jpg',
            ),
            _buildMemberSection(
              title: 'Principal',
              name: 'Dr. J Praveen',
              description: 'Principal, GRIET, Hyderabad',
              image: 'assets/principal.jpg',
            ),
            _buildMemberSection(
              title: 'AAC Faculty Coordinator',
              name: 'Dr. M Kiran Kumar',
              description: 'AAC Faculty Coordinator, GRIET, Hyderabad',
              image: 'assets/kk.jpg',
            ),
            _buildMemberSection(
              title: 'SDC Faculty Coordinator',
              name: 'Dr. GS Bapiraju',
              description: 'SDC Faculty Coordinator, GRIET, Hyderabad',
              image: 'assets/bapiraju.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberSection(
      {required String title,
      required String name,
      required String description,
      required String image}) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0, top: 10),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
