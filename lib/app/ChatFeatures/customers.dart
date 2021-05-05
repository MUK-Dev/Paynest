import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_currency_app/app/ChatFeatures/chat_screen.dart';
import 'package:crypto_currency_app/color_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../nav_drawer.dart';

class CustomersScreen extends StatefulWidget {
  static String id = '/customerScreen';

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
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
            shadowColor: Colors.blue,
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
        color: Colors.white,
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
        String firstName = user.data()['firstName'];
        String lastName = user.data()['lastName'];
        if (user.data()['admin'] == false) {
          return Card(
            color: Provider.of<ColorChanger>(context).showColor
                ? Colors.red
                : Colors.white,
            elevation: 10,
            child: ListTile(
              trailing: Text(user.data()['email']),
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/users.png',
                ),
              ),
              onTap: () {
                Provider.of<ColorChanger>(context, listen: false)
                    .changeIt(false);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatScreen(
                    currentUser: user,
                  );
                }));
              },
              title: Text('$firstName $lastName'),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
