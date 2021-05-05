import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crypto_currency_app/Authentication/sign_in.dart';
import 'package:crypto_currency_app/app/home_page.dart';
import 'package:crypto_currency_app/raised_button_for_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'form_fields.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
//Variables
  bool terms = false;
  bool recieveEmails = false;
  String email;
  String password;
  String confirmPass;
  bool passwordObscurity = true;
  String first;
  String last;
  String authorization = 'user';
  String phoneNumber;
  final _formKey = GlobalKey<FormState>();
  bool errorPassword = false;
  bool _showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String _error;
  User currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final validateEmail = MultiValidator([
    RequiredValidator(errorText: 'Email is empty, Enter Email'),
    MaxLengthValidator(40, errorText: 'Email is too long'),
  ]);

  final validatePassword = MultiValidator([
    RequiredValidator(errorText: 'Password is Required'),
    MinLengthValidator(6, errorText: 'Password should be atleast 6 characters'),
  ]);

  final requiredFields = MultiValidator([
    RequiredValidator(errorText: 'Empty'),
  ]);

//Methods
  void validate() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _showSpinner = true;
      });
      registerUser();
      print('Validation Done');
    } else
      return;
  }

  void geCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        currentUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void registerUser() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      storeUserData();
    } catch (e) {
      setState(() {
        _error = e.message;
        _showSpinner = false;
      });
    }
  }

  Future<void> storeUserData() async {
    return await users.add({
      'email': email,
      'firstName': first,
      'lastName': last,
      'number': phoneNumber,
      'recieveEmails': recieveEmails,
      'termsAgree': terms,
      'admin': false,
    }).then((value) {
      setState(() {
        _showSpinner = false;
      });
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    });
  }

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

//Body of the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 5,
                    ),
                    child: TyperAnimatedTextKit(
                      text: ['Hello'],
                      textStyle: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 50,
                        color: Color(0xff38B6FF),
                      ),
                      isRepeatingAnimation: false,
                      speed: Duration(milliseconds: 250),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InputFields(
                                label: 'First Name',
                                obscure: false,
                                change: (value) {
                                  first = value;
                                },
                                formValidation: requiredFields,
                              ),
                            ),
                            Expanded(
                              child: InputFields(
                                label: 'Last Name',
                                change: (value) {
                                  last = value;
                                },
                                obscure: false,
                                formValidation: requiredFields,
                              ),
                            ),
                          ],
                        ),
                        InputFields(
                          label: 'Email',
                          obscure: false,
                          typeOfKeyboard: TextInputType.emailAddress,
                          change: (value) {
                            email = value;
                          },
                          hint: 'Recommended: Gmail',
                          formValidation: validateEmail,
                        ),
                        InputFields(
                          label: 'Password',
                          obscure: passwordObscurity,
                          formValidation: validatePassword,
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
                        InputFields(
                          label: 'Confirm Password',
                          obscure: passwordObscurity,
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
                          formValidation: (value) {
                            return MatchValidator(
                                    errorText: "Passwords Don't Match")
                                .validateMatch(password, value);
                          },
                        ),
                        InputFields(
                          obscure: false,
                          label: 'Phone Number',
                          typeOfKeyboard: TextInputType.number,
                          formValidation: requiredFields,
                          change: (value) {
                            phoneNumber = value;
                          },
                        ),
                        CheckboxListTile(
                          value: terms,
                          onChanged: (value) {
                            setState(() {
                              terms = value;
                            });
                          },
                          title: Text('I agree to terms & conditions'),
                          controlAffinity: ListTileControlAffinity.leading,
                          secondary: Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Icon(
                              Icons.check,
                              color: terms ? Color(0xff38B6FF) : null,
                              size: 30,
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          value: recieveEmails,
                          onChanged: (value) {
                            setState(() {
                              recieveEmails = value;
                            });
                          },
                          title: Text('I agree to receive Emails'),
                          controlAffinity: ListTileControlAffinity.leading,
                          secondary: Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Icon(
                              Icons.email,
                              color: recieveEmails ? Color(0xff38B6FF) : null,
                              size: 30,
                            ),
                          ),
                        ),
                        showAlert(),
                        Container(
                          child: Buttons(
                            text: 'Register',
                            onTap: () {
                              validate();
                            },
                            buttonColor: Color(0xff38B6FF),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignInScreen.id);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Already Registered? Sign in",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff38B6FF),
                              ),
                            ),
                          ),
                        ),
                      ],
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
