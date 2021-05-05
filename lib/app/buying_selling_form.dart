import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_currency_app/raised_button_for_all.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:crypto_currency_app/Authentication/form_fields.dart';
import 'package:provider/provider.dart';

import '../color_changer.dart';

class CurrencyDealingForm extends StatefulWidget {
  static String id = '/dealingPage';
  final String name;
  CurrencyDealingForm({this.name});
  @override
  _CurrencyDealingFormState createState() => _CurrencyDealingFormState();
}

class _CurrencyDealingFormState extends State<CurrencyDealingForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List allUsers;
  final _formKey = GlobalKey<FormState>();
  final requiredFields = MultiValidator([
    RequiredValidator(errorText: 'Empty'),
  ]);
  String amount;
  String walletNumber;
  String amountNaira;
  String amountToPay;
  SnackBar newSnackbar = SnackBar(
    content: Text(
        'Your Message has been sent to admin\nYou can chat with admin in the chat section'),
    duration: Duration(milliseconds: 4000),
  );

  Future<String> getUserData() async {
    String id;
    final users = await _firestore.collection('users').getDocuments();
    allUsers = users.docs;
    allUsers.forEach((element) {
      if (element.data()['email'] == _auth.currentUser.email) {
        id = element.documentID;
      }
    });
    return id;
  }

  void buy() async {
    String userID = await getUserData();
    _firestore.collection('/users/$userID/chat').add({
      'message':
          "I want to buy ${widget.name}\nAmount: $amount\nAmount Equivalent in NaIra: $amountNaira\nMy wallet address is: $walletNumber\nAmount You are to pay: $amountToPay",
      'email': _auth.currentUser.email,
      'timeStamp': FieldValue.serverTimestamp(),
    });
    Provider.of<ColorChanger>(context, listen: false).changeIt(true);
    _scaffoldKey.currentState.showSnackBar(newSnackbar);
  }

  void sell() async {
    String userID = await getUserData();
    _firestore.collection('/users/$userID/chat').add({
      'message':
          "I want to sell ${widget.name}\nAmount: $amount\nAmount Equivalent in NaIra: $amountNaira\nMy wallet address is: $walletNumber",
      'email': _auth.currentUser.email,
      'timeStamp': FieldValue.serverTimestamp(),
    });
    Provider.of<ColorChanger>(context, listen: false).changeIt(true);
    _scaffoldKey.currentState.showSnackBar(newSnackbar);
  }

  void validateBuyRequest() {
    if (_formKey.currentState.validate()) {
      buy();
    } else
      return;
  }

  void validateSellRequest() {
    if (_formKey.currentState.validate()) {
      sell();
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
            ),
            child: TyperAnimatedTextKit(
              text: ['Deal Digital Assets'],
              textStyle: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 25,
                color: Color(0xff38B6FF),
              ),
              isRepeatingAnimation: false,
              speed: Duration(milliseconds: 50),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'How much do you want to buy?',
                  style: TextStyle(
                      fontFamily: 'Texturina', fontSize: 20, color: Colors.red),
                ),
                InputFields(
                  obscure: false,
                  hint: 'Enter Amount Here',
                  change: (value) {
                    amount = value;
                  },
                  formValidation:
                      RequiredValidator(errorText: 'Please Enter Amount'),
                ),
                Text(
                  'Equivalent in NaIra',
                  style: TextStyle(
                      fontFamily: 'Texturina', fontSize: 20, color: Colors.red),
                ),
                InputFields(
                  obscure: false,
                  hint: 'Enter Amount Here',
                  change: (value) {
                    amountNaira = value;
                  },
                  formValidation:
                      RequiredValidator(errorText: 'Please Enter Amount'),
                ),
                Text(
                  'Enter Wallet Address',
                  style: TextStyle(
                      fontFamily: 'Texturina', fontSize: 20, color: Colors.red),
                ),
                InputFields(
                  obscure: false,
                  hint: 'Enter Number Here',
                  change: (value) {
                    walletNumber = value;
                  },
                  formValidation:
                      RequiredValidator(errorText: 'Please Enter Address'),
                ),
                Text(
                  'Amount We are to Pay',
                  style: TextStyle(
                      fontFamily: 'Texturina', fontSize: 20, color: Colors.red),
                ),
                InputFields(
                  obscure: false,
                  hint: 'Enter Amount Here',
                  change: (value) {
                    amountToPay = value;
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 30, left: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Buttons(
                    text: 'Buy',
                    onTap: () {
                      validateBuyRequest();
                    },
                  ),
                ),
                Text('OR'),
                Expanded(
                  child: Buttons(
                    text: 'Sell',
                    onTap: () {
                      validateSellRequest();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
