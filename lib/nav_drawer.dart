import 'package:crypto_currency_app/app/about_us.dart';
import 'package:crypto_currency_app/app/instructions_page.dart';
import 'package:crypto_currency_app/app/profile_page.dart';
import 'package:crypto_currency_app/currencies/getCurrencies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authentication/welcome_screen.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff38B6FF),
            ),
            child: ListView(
              padding: EdgeInsets.only(top: 40),
              children: [
                Tiles(
                  icon: Icon(Icons.person),
                  tap: () {
                    Navigator.pushNamed(context, ProfilePage.id);
                  }, //TODO: create a profile page for user
                  text: 'Profile',
                ),
                Container(
                  height: 50,
                  color: Colors.black12,
                ),
                Tiles(
                  icon: Icon(Icons.info_outline),
                  tap: () {
                    Navigator.pushNamed(context, InstructionsPage.id);
                  },
                  text: "Instructions",
                ),
                Tiles(
                  icon: Icon(Icons.article_outlined),
                  text: "Currency list",
                  tap: () {
                    Navigator.pushNamed(context, GetCurrencies.id);
                  },
                ),
                Container(
                  height: 50,
                  color: Colors.black12,
                ),
                Tiles(
                  icon: Icon(Icons.person_outline),
                  tap: () {
                    Navigator.pushNamed(context, AboutUsScreen.id);
                  },
                  text: "About Us",
                ),
                Tiles(
                  icon: Icon(Icons.power_settings_new),
                  tap: () {
                    _auth.signOut();
                    setState(() {
                      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                    });
                  },
                  text: "Sign out",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tiles extends StatelessWidget {
  final Function tap;
  final Icon icon;
  final String text;
  Tiles({this.icon, this.tap, this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.blue,
      leading: (text == 'Profile')
          ? Container(
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/users.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            )
          : icon,
      title: Text(
        text,
        style: TextStyle(fontFamily: 'Texturina', fontSize: 15),
      ),
      onTap: tap,
    );
  }
}
