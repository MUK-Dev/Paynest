import 'package:flutter/material.dart';

//Buttons properties & customize buttons here
class Buttons extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color buttonColor;
  Buttons({this.text, this.onTap, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 7,
        color: buttonColor,
        padding: EdgeInsets.all(20),
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}
