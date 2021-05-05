import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_currency_app/app/ChatFeatures/chat_screen.dart';
import 'package:crypto_currency_app/color_changer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../nav_drawer.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class UserChatScreen extends StatefulWidget {
  static String id = '/userChatScreen';

  @override
  _UserChatScreenState createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.black)),
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          drawer: NavDrawer(),
          appBar: AppBar(
            elevation: 10,
            backgroundColor: Colors.white,
          ),
          body: StreamBuilder(
            stream: _firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                        child: Text('Something went wrong Try later'));
                  } else {
                    final users = snapshot.data.documents;
                    if (users.isEmpty) {
                      return Center(
                        child: Text('No Users Found'),
                      );
                    } else {
                      return chatBodyWidget(users: users);
                    }
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}

class chatBodyWidget extends StatelessWidget {
  final List users;
  List<String> documents;
  chatBodyWidget({
    this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xff38B6FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: allChats(),
    );
  }

  Widget allChats() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        String email = user.data()['email'];
        if (user.data()['admin'] == false && _auth.currentUser.email == email) {
          return Container(
            margin: EdgeInsets.all(30),
            child: RaisedButton(
              elevation: 30,
              splashColor: Colors.red,
              color: Provider.of<ColorChanger>(context).showColor
                  ? Colors.red
                  : Colors.white,
              onPressed: () {
                Provider.of<ColorChanger>(context, listen: false)
                    .changeIt(false);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatScreen(
                    currentUser: user,
                  );
                }));
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/users.png'),
                      radius: 40,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Tap Here \nIf you need assistance",
                      style: TextStyle(
                        fontFamily: 'Texturina',
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
