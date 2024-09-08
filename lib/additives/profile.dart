import 'package:flutter/material.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollnoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile Settings'),
        backgroundColor: Colors.orange[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profile.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  TextFieldWidget('Name', Icons.person_outline, nameController),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      'Roll Number', Icons.numbers_outlined, rollnoController),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      'Phone Number', Icons.phone_android, phoneController),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      'Email', Icons.email_outlined, emailController),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      greenButton('Cancel', () {
                        Navigator.pop(context);
                      }),
                      SizedBox(
                        width: 5,
                      ),
                      greenButton('Submit', () {
                        Navigator.pop(context);
                      })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget introWidget() {
    return Container(
      /*decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/mask.png'),
          fit: BoxFit.fill,
        ),
      ),*/
      height: 300,
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 50),
        child: Center(
          child: Text(
            "Profile Settings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Widget TextFieldWidget(
    String title, IconData iconData, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xffA7A7A7),
        ),
      ),
      const SizedBox(
        height: 6,
      ),
      Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xffA7A7A7),
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Icon(
                iconData,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

Widget greenButton(String title, Function onPressed) {
  return MaterialButton(
    height: 50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    color: Colors.green,
    onPressed: () => onPressed(),
    child: Text(
      title,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
