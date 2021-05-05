import 'package:crypto_currency_app/Authentication/register.dart';
import 'package:crypto_currency_app/Authentication/sign_in.dart';
import 'package:crypto_currency_app/Authentication/welcome_screen.dart';
import 'package:crypto_currency_app/app/ChatFeatures/chat_screen.dart';
import 'package:crypto_currency_app/app/ChatFeatures/customers.dart';
import 'package:crypto_currency_app/app/ChatFeatures/userChat.dart';
import 'package:crypto_currency_app/app/about_us.dart';
import 'package:crypto_currency_app/app/buy_sell_giftcard.dart';
import 'package:crypto_currency_app/app/buying_selling_form.dart';
import 'package:crypto_currency_app/app/home_page.dart';
import 'package:crypto_currency_app/app/instructions_page.dart';
import 'package:crypto_currency_app/app/profile_page.dart';
import 'package:crypto_currency_app/color_changer.dart';
import 'package:crypto_currency_app/currencies/getCurrencies.dart';
import 'package:crypto_currency_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

List currencies;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  currencies = await getCurrencies();
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ColorChanger(),
      child: MaterialApp(
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(), //Starting Point of app
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          GetCurrencies.id: (context) => GetCurrencies(currencies: _currencies),
          CustomersScreen.id: (context) => CustomersScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          UserChatScreen.id: (context) => UserChatScreen(),
          ProfilePage.id: (context) => ProfilePage(),
          InstructionsPage.id: (context) => InstructionsPage(),
          AboutUsScreen.id: (context) => AboutUsScreen(),
          GiftCardForm.id: (context) => GiftCardForm(),
        },
      ),
    );
  }
}
//

Future<List> getCurrencies() async {
  String cryptoUrl =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?${API_KEY_HERE}&limit=50";
  http.Response response = await http.get(cryptoUrl);
  if (response.statusCode != 200) {
    print('Did not return data');
  } else {
    return json.decode(response.body)["data"];
  }
}
