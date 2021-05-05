import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crypto_currency_app/Authentication/register.dart';
import 'package:crypto_currency_app/Authentication/sign_in.dart';
import 'package:flutter/material.dart';

import '../raised_button_for_all.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff38B6FF),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, right: 30, left: 30),
                  child: TyperAnimatedTextKit(
                    isRepeatingAnimation: false,
                    speed: Duration(milliseconds: 150),
                    text: ['Paynest'],
                    textStyle: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 50,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, top: 10, right: 30),
                  child: Text(
                    'Crypto Exchange has never been this easy!!!',
                    style: TextStyle(
                      fontFamily: 'Texturina',
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(40),
              child: Hero(
                tag: 'top',
                child: Image(
                  image: AssetImage('assets/images/topImage.png'),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Buttons(
                  text: 'Register',
                  onTap: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  buttonColor: Colors.white,
                ),
                Buttons(
                  text: 'Sign in',
                  onTap: () {
                    Navigator.pushNamed(context, SignInScreen.id);
                  },
                  buttonColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
