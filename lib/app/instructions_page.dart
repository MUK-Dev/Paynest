import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  static String id = '/instructions';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.black)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('19xx Softwares'),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                'Chat with us',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 35,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'We are always here to assist you incase you need any help\nChat with us any time, we will reply you as quickly as we can\nJust Press the chat button below, It is that simple',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'How to buy/sell',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 35,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "1) Click on buy/sell button on home page\n2) Select the currency you want to buy/sell, it will direct you to a form\n3) Fill out the form\n4) CLick on the buy/sell button\n5) It will generate a message that will be sent to the admin\n6)The admin will then guide you on how you can buy/sell your desired item",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'Cryptocurrencies that we deal with.',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Bitcoin\nEthereum\nTether\nLitecoin\nBinance Coin\nBinance USD\nWeb Money\nRipple",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'For prices of Web Money and Ripple Please contact us',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 20),
              Text(
                'Gift Cards',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 35,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "You can also buy and sell gift cards with us",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'What is Cryptocurrency?',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "A cryptocurrency (or crypto currency or crypto for short) is a digital asset designed to work as a medium of exchange wherein individual coin ownership records are stored in a ledger existing in a form of computerized database using strong cryptography to secure transaction records, to control the creation of additional coins, and to verify the transfer of coin ownership. It typically does not exist in physical form (like paper money) and is typically not issued by a central authority. Cryptocurrencies typically use decentralized control as opposed to centralized digital currency and central banking systems. When a cryptocurrency is minted or created prior to issuance or issued by a single issuer, it is generally considered centralized. When implemented with decentralized control, each cryptocurrency works through distributed ledger technology, typically a blockchain, that serves as a public financial transaction database.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
// Text(
//                 'Description',
//                 style: TextStyle(
//                   fontFamily: 'Pacifico',
//                   fontSize: 35,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//               Text('data')
