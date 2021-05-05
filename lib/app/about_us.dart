import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static String id = '/aboutUs';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '19xx Softwares',
          style: TextStyle(
            fontFamily: 'Texturina',
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              'About Us',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 35,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "We are an innovative software company that handles all your business needs from graphics and advertising to the complexity in building a good system that works. With our precessional team and years of experience we know we would serve you better with the best. We are also a crypto currency exchange company.",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Details',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 20),
            SelectableText(
              'Our Phone Number: 07055948800',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            SelectableText(
              'Email Us at: 19xxcoo@gmail.com',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              "You can copy the email and number from here",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            Text(
              'Office Timings',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Monday: 9:00 AM - 6:00 PM\nTuesday: 9:00 AM - 6:00 PM\nWednesday: 9:00 AM - 6:00 PM\nThursday: 9:00 AM - 6:00 PM\nFriday: 9:00 AM - 6:00 PM\nSaturday: 11:00 AM - 4:00 PM",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
