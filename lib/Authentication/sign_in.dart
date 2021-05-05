import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crypto_currency_app/Authentication/form_fields.dart';
import 'package:crypto_currency_app/Authentication/register.dart';
import 'package:crypto_currency_app/app/home_page.dart';
import 'package:crypto_currency_app/raised_button_for_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInScreen extends StatefulWidget {
  static String id = '/signin';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //Variables
  bool passwordObscurity = true;
  bool errorPassword = false;
  bool _showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String _error;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  final validateEmail = MultiValidator([
    RequiredValidator(errorText: 'Email is empty, Enter Email'),
    MaxLengthValidator(40, errorText: 'Email is too long'),
  ]);

  final validatePassword = MultiValidator([
    RequiredValidator(errorText: 'Password is Required'),
    MinLengthValidator(6, errorText: 'Password should be atleast 6 characters'),
  ]);

//Methods
  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(_error),
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                })
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  void loginUser() async {
    try {
      final User = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(context, HomeScreen.id);
      setState(() {
        _showSpinner = false;
      });
    } catch (e) {
      setState(() {
        _error = e.message;
        _showSpinner = false;
      });
    }
  }

  void validate() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _showSpinner = true;
      });
      loginUser();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff38B6FF),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'top',
                    child: Container(
                      padding: EdgeInsets.all(23),
                      child: Image(
                        image: AssetImage('assets/images/topImage.png'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TyperAnimatedTextKit(
                      text: ['Welcome Back'],
                      isRepeatingAnimation: false,
                      speed: Duration(milliseconds: 100),
                      textStyle:
                          TextStyle(fontFamily: 'Pacifico', fontSize: 40),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputFields(
                          label: 'Email',
                          obscure: false,
                          filled: true,
                          change: (value) {
                            email = value;
                          },
                        ),
                        InputFields(
                          label: 'Password',
                          obscure: passwordObscurity,
                          filled: true,
                          change: (value) {
                            password = value;
                          },
                          iconType: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                passwordObscurity
                                    ? passwordObscurity = false
                                    : passwordObscurity = true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  showAlert(),
                  Center(
                    child: Buttons(
                      text: 'Sign in',
                      onTap: () {
                        validate();
                      },
                    ),
                  ),
                  Center(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "New to Paynest? Register Today!",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
