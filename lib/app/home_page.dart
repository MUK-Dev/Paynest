import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crypto_currency_app/Authentication/form_fields.dart';
import 'package:crypto_currency_app/app/buy_sell_giftcard.dart';
import 'package:crypto_currency_app/bottom_nav_bar.dart';
import 'package:crypto_currency_app/currencies/getCurrencies.dart';
import 'package:crypto_currency_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_currency_app/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.black),
      ),
      child: SafeArea(
        child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            shadowColor: Colors.blue,
            elevation: 10,
            backgroundColor: Colors.white,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/homeBg.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TyperAnimatedTextKit(
                        text: ['Overview'],
                        textStyle: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 30,
                        ),
                        isRepeatingAnimation: false,
                        speed: Duration(milliseconds: 130),
                      ),
                      Card(
                        color: Color(0xff38B6FF),
                        margin: EdgeInsets.only(bottom: 10),
                        elevation: 15,
                        child: InputFields(
                          obscure: false,
                          filled: true,
                          label: 'Search',
                          iconType: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              Navigator.pushNamed(context, GetCurrencies.id);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          'What would you like to do?',
                          style: TextStyle(
                            fontFamily: 'Texturina',
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RaisedButtonHome(
                              text: 'Buy Crypto',
                              onTap: () {
                                Navigator.pushNamed(context, GetCurrencies.id);
                              },
                            ),
                          ),
                          Expanded(
                            child: RaisedButtonHome(
                              text: 'Sell Crypto',
                              onTap: () {
                                Navigator.pushNamed(context, GetCurrencies.id);
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RaisedButtonHome(
                              text: 'Buy Gift Card',
                              onTap: () {
                                Navigator.pushNamed(context, GiftCardForm.id);
                              },
                            ),
                          ),
                          Expanded(
                            child: RaisedButtonHome(
                              text: 'Sell Gift Card',
                              onTap: () {
                                Navigator.pushNamed(context, GiftCardForm.id);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBarAllScreens(),
        ),
      ),
    );
  }
}

class RaisedButtonHome extends StatelessWidget {
  final Function onTap;
  final String text;
  RaisedButtonHome({this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.all(18),
      child: RaisedButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.blue[50],
          ),
        ),
        splashColor: Colors.red,
        elevation: 10,
        color: Colors.blue[50],
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff38B6FF),
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
