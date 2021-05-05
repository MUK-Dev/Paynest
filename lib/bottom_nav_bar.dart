import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_currency_app/app/ChatFeatures/customers.dart';
import 'package:crypto_currency_app/app/ChatFeatures/userChat.dart';
import 'package:crypto_currency_app/app/instructions_page.dart';
import 'package:crypto_currency_app/app/profile_page.dart';
import 'package:crypto_currency_app/color_changer.dart';
import 'package:crypto_currency_app/currencies/getCurrencies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomAppBarAllScreens extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List allUsers;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> getUserData() async {
    bool admin;
    final users = await _firestore.collection('users').getDocuments();
    allUsers = users.docs;
    allUsers.forEach((element) {
      if (element.data()['email'] == _auth.currentUser.email) {
        admin = element.data()['admin'];
      }
    });
    return admin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blue,
          blurRadius: 100,
        ),
      ]),
      child: BottomAppBar(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonsInNavBar(
              onTap: () {
                Navigator.pushNamed(context, GetCurrencies.id);
              },
              iconType: Icons.article_outlined,
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: IconButton(
                icon: Icon(
                  Icons.person_outline,
                  size: 40,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ProfilePage.id);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: IconButton(
                icon: Icon(
                  Icons.info_outline,
                  size: 40,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, InstructionsPage.id);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: IconButton(
                  icon: Icon(
                    Icons.chat_outlined,
                    size: 40,
                    color: Provider.of<ColorChanger>(context).showColor
                        ? Colors.red
                        : Colors.grey[600],
                  ),
                  onPressed: () async {
                    bool isAdmin = await getUserData();
                    if (isAdmin) {
                      Navigator.pushNamed(context, CustomersScreen.id);
                    } else if (!isAdmin) {
                      Navigator.pushNamed(context, UserChatScreen.id);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonsInNavBar extends StatelessWidget {
  final Function onTap;
  final IconData iconType;
  ButtonsInNavBar({this.iconType, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: IconButton(
        icon: Icon(
          iconType,
          size: 40,
          color: Colors.grey[600],
        ),
        onPressed: onTap,
      ),
    );
  }
}
