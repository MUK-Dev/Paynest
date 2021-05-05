import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_currency_app/app/ChatFeatures/customers.dart';
import 'package:crypto_currency_app/app/ChatFeatures/userChat.dart';
import 'package:crypto_currency_app/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../nav_drawer.dart';

class ProfilePage extends StatefulWidget {
  static String id = '/profilePage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List allUsers;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  void getUserData() async {
    final users = await _firestore.collection('users').getDocuments();
    allUsers = users.docs;
    await allUsers.forEach((element) {
      if (element.data()['email'] == _auth.currentUser.email) {
        setState(() {
          firstName = element.data()['firstName'];
          lastName = element.data()['lastName'];
          phoneNumber = element.data()['number'];
          email = element.data()['email'];
        });
      }
    });
  }

  @override
  void initState() {
    getUserData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.black)),
      child: Scaffold(
        backgroundColor: Color(0xff38B6FF),
        drawer: NavDrawer(),
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomAppBarAllScreens(),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 20),
              height: 130,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/users.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            ProfileDataBlock(
              title: 'Name',
              userData: '$firstName $lastName',
            ),
            Container(
              height: 60,
              color: Color(0xff38B6FF),
            ),
            ProfileDataBlock(
              title: 'Email',
              userData: '$email',
            ),
            Container(
              height: 60,
              color: Color(0xff38B6FF),
            ),
            ProfileDataBlock(
              title: 'Phone Number',
              userData: '$phoneNumber',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDataBlock extends StatelessWidget {
  final String title;
  final String userData;
  ProfileDataBlock({
    this.title,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Pacifico', fontSize: 25, color: Colors.white),
          ),
          Text(
            userData,
            style: TextStyle(
                fontFamily: 'Texturina', fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
