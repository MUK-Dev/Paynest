import 'package:crypto_currency_app/Authentication/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  static String id = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff38B6FF),
        child: Center(
          child: Text(
            'PayNest',
            style: TextStyle(
              fontFamily: 'Texturina',
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
